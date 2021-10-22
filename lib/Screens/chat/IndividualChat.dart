// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:chatki_project/Screens/chat/OwnMessageCard.dart';
import 'package:chatki_project/Screens/chat/ReplyCard.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class IndividualChat extends StatefulWidget {
  const IndividualChat({Key? key}) : super(key: key);

  @override
  _IndividualChatState createState() => _IndividualChatState();
}

class _IndividualChatState extends State<IndividualChat> {
  late Socket socket;

  @override
  void initState() {
    socket = io(
        'http://127.0.0.1:3000',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .build());
    socket.connect();
    super.initState();

    print("Hello");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            backgroundColor: Colors.grey[900],
            elevation: 5,
            title: Text(
              "Friend Name", //<----------------------------------****
              style: TextStyle(
                letterSpacing: 4,
              ),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 23,
                  //onPressed: () {},
                ),
              ),
            ],
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 25,
                color: Colors.white,
              ),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.red],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
              ),
            ),
          ),
          //backgroundColor: Colors.blueGrey,
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 50,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      OwnMessageCard(),
                      ReplyCard(),
                      ReplyCard(),
                      OwnMessageCard(),
                      OwnMessageCard(),
                      OwnMessageCard(),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 55,
                        color: Colors.grey[900],
                        child: Card(
                          margin: EdgeInsets.only(
                              left: 10, right: 10, bottom: 10, top: 10),
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
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 55,
                        height: 69,
                        color: Colors.grey[900],
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 25,
                            child: IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.send),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
