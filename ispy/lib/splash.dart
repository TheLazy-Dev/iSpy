import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ispy/add_user.dart';
import 'package:ispy/home.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late IO.Socket socket;
  @override
  Widget build(BuildContext context) {
    getUsername();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("iSpy", style: Theme.of(context).textTheme.headline4),
            LottieBuilder.asset(
              "assets/84272-loading-colour.json",
              frameRate: FrameRate.composition,
              fit: BoxFit.scaleDown,
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
            ),
            Text("App By Denish Goklani",
                style: Theme.of(context).textTheme.headline6),
          ],
        ),
      ),
    );
  }

  void getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    if ((username?.isNotEmpty ?? false) || username != null) {
      print("username is $username");

      try {
        socket = IO.io("http://localhost:3000", <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': false,
        });

        socket.connect();
        socket.onConnect((data) {
          socket.emit("message",
              json.encode({"event": "register", "username": username}));
        });

        socket.on("loggedin", (data) {
          print(data);
          if (mounted && socket.connected) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LandingPage(
                    username: username,
                  ),
                ));
          }
        });
      } on Exception catch (e) {
        print(e);
      }
    } else if (username == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const AddMe()));
    }
  }
}
