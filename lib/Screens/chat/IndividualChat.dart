// ignore_for_file: file_names

import 'package:chatki_project/Screens/chat/OwnMessageCard.dart';
import 'package:chatki_project/Screens/chat/ReplyCard.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class IndividualChat extends StatefulWidget {
  const IndividualChat({Key? key}) : super(key: key);

  @override
  _IndividualChatState createState() => _IndividualChatState();
}

class _IndividualChatState extends State<IndividualChat> {

  late IO.Socket socket;

  void connect()
  {
    // socket = IO.io(uri));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            backgroundColor: Colors.blueGrey,
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(children: [
                  Container(
                    height: MediaQuery.of(context).size.height -60,
                    child: ListView(shrinkWrap: true, children: [
                      OwnMessageCard(),
                      ReplyCard(),
                      
                      
                    ]),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width - 55,
                              child: Card(
                                margin: EdgeInsets.only(
                                    left: 2, right: 2, bottom: 8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                child: TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                      hintText: "Type a message",
                                      contentPadding: EdgeInsets.all(15),
                                    )),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8, left: 2),
                            child: CircleAvatar(
                              radius: 25,
                              child: IconButton(
                                icon: Icon(Icons.send),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ))
                ]))),
      ],
    );
  }
}
