/// user will be shown this page if the username is not found in memory
/// that mostly happens when user has cleared the memory or freshly installs the app.
///
/// Socket init will be done along with username saving to memory
///
///

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ispy/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AddMe extends StatefulWidget {
  const AddMe({Key? key}) : super(key: key);

  @override
  _AddMeState createState() => _AddMeState();
}

class _AddMeState extends State<AddMe> {
  late IO.Socket socket;
  TextEditingController usernameController = TextEditingController(
    text: '',
  );
  var error = false;
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        title: const Text('Enter a Username'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Username',
                ),
                onChanged: (String value) {
                  usernameController.text = value;
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Visibility(
              child: Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
              visible: error,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('DONE'),
            onPressed: () async {
              if (usernameController.text.isEmpty ||
                  usernameController.text.length < 3 ||
                  usernameController.text.length > 15) {
                setState(() {
                  error = true;
                  errorMessage =
                      'Username must be at least 3 characters and less than 15 characters';
                });
              } else if (usernameController.text.contains(" ")) {
                setState(() {
                  error = true;
                  errorMessage = 'Username cannot contain spaces';
                });
              } else {
                socket = IO.io("http://localhost:3000", <String, dynamic>{
                  'transports': ['websocket'],
                  'autoConnect': false,
                });

                socket.connect();
                socket.onConnect((data) {
                  socket.emit(
                      "message",
                      json.encode({
                        "event": "register",
                        "username": usernameController.text
                      }));
                });
                socket.on("loggedin", (data) async {
                  print(data);
                  if (mounted && socket.connected) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('username', usernameController.text);
                    String userName = usernameController.text;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LandingPage(
                          username: userName,
                          id: data,
                        ),
                      ),
                    );
                  }
                  ;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }
}
