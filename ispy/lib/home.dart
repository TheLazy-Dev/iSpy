import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ispy/chat_screens/main_chat_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class LandingPage extends StatefulWidget {
  LandingPage({this.username, Key? key}) : super(key: key);
  var username;
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  IO.Socket socket = IO.io('http://localhost:3000', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
    'forceNew': true,
  });

  var jsonData;
  late ConnectionState connectionState;
  @override
  void initState() {
    connectionState = ConnectionState.waiting;
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (connectionState == ConnectionState.waiting) {
      return Scaffold(
        body: Center(
          child: Lottie.asset('assets/84272-loading-colour.json'),
        ),
      );
    } else if (connectionState == ConnectionState.done && jsonData != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Online Players'),
        ),
        body: ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatScreen(
                                myUserName: widget.username,
                                particiapantUserName: jsonData[index]
                                    ["username"],
                              ))),
                  title: Text(jsonData[index]["username"]),
                ),
              );
            },
            itemCount: jsonData.length),
      );
    } else {
      return const Scaffold(body: Text("error"));
    }
  }

  Future<void> getUsers() async {
    // connect socket
    socket.connect();
    // send reqest to server for
    socket.onConnect(
        (data) => socket.emit("message", json.encode({"event": "getAll"})));

    //getting data
    socket.on("allUsers", (data) {
      setState(() {
        connectionState = ConnectionState.done;
        jsonData = json.decode(data);
      });
    });
  }
}
