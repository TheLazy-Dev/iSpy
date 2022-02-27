import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({this.myUserName, this.particiapantUserName, Key? key})
      : super(key: key);
  var myUserName, particiapantUserName;
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String tries = '3';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game with ${widget.particiapantUserName}"),
      ),
      body: const Scaffold(
        body: Text("Chat"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          int.parse(tries) > 0
              ? setState(() {
                  tries = (int.parse(tries) - 1).toString();
                })
              : AlertDialog(
                  title: Text("Game Over"),
                  content: Text("${widget.particiapantUserName} lost the game"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
        },
        label: Text("Guess Left for ${widget.particiapantUserName} : $tries"),
      ),
    );
  }
}
