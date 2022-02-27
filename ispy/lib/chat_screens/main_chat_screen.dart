/// 1. if user quits the game in the middle of the game
/// then the game will be over and the player will be notified
/// response {"message":"Other player has left the game"}
///
/// 2. if the connection is unreliable, then the Socket timeout in 30 seconds
/// response {"message":"Socket timeout"}
///
/// 3. if the user send correct image along with character
/// response {"image":base64,"character":TextEditingController.text}
///
/// 4. if the other user guesses it correctly
/// response {"message":"You Win"}
///
/// 5. response to the first player
/// response {"message":"<the other player> won the game"}
/// There are scenarios which I could think of currently

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  ChatScreen({this.myUserName, this.particiapantUserName, Key? key})
      : super(key: key);
  var myUserName, particiapantUserName;
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String tries = '3';
  late var letter;
  late IO.Socket socket;
  late var _controller = TextEditingController();
  @override
  void initState() {
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': false,
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.particiapantUserName;
    if (socket.connected) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Game with ${widget.particiapantUserName}"),
          actions: [Text("Quit ")],
        ),
        body: Scaffold(
            body: SafeArea(
          child: Stack(
            children: [
              Column(children: [
                SizedBox(
                  child: Text(
                      "iSpy with my little eye a thing that starts with letter $letter"),
                  height: 120.h,
                ),
              ]),
              Positioned(
                  bottom: 100,
                  right: 10,
                  child: FloatingActionButton(
                    child: Icon(Icons.send),
                    tooltip: 'Send',
                    onPressed: () {},
                  )),
            ],
          ),
        )),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            int.parse(tries) > 0
                ? setState(() {
                    tries = (int.parse(tries) - 1).toString();
                  })
                : AlertDialog(
                    title: Text("Game Over"),
                    content:
                        Text("${widget.particiapantUserName} lost the game"),
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
          label: Text(
              "Guesses Left for ${widget.particiapantUserName} : 3\n Guesses Left for you : 3"),
        ),
      );
    } else {
      return Lottie.asset('assets/84272-loading-colour.json');
    }
  }
}
