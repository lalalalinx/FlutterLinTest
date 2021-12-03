// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors

// sender , reciever

import 'dart:async';
import 'package:chatki_project/Model/MessageData.dart';
import 'package:chatki_project/Screens/ChatView.dart';
import 'package:chatki_project/Screens/Home.dart';
import 'package:chatki_project/Screens/chat/OwnMessageCard.dart';
import 'package:chatki_project/Screens/chat/ReplyCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';

class IndividualChat extends StatefulWidget {
  const IndividualChat({
    Key? key,
    required this.chatID,
    required this.chatName,
    required this.targetID,
  }) : super(key: key);
  final String chatID;
  final String chatName;
  final String targetID;

  @override
  _IndividualChatState createState() => _IndividualChatState();
}

class _IndividualChatState extends State<IndividualChat> {
  late Socket socket;
  final storage = FlutterSecureStorage();
  List<MessageData> messages = [];
  late String employeeID;

  //controller
  TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    connectSocket();
    super.initState();
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  // connect to socketio and recieve previous message and incoming message
  Future connectSocket() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    socket = io('https://chattycat-heroku.herokuapp.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'forceNew': true,
    });

    socket.connect();
    socket.onConnect((data) {
      print("Connected");
    });
    employeeID = prefs.getString('employeeID')!;
    socket.emit("signin", {employeeID, widget.chatID, -1});

    // load previous message
    socket.on('loadUniqueChat', (data) {
      var username = prefs.getString('username');
      if (data["sender"] == username) {
        print("sender $mounted");
        loadMessage("source", data["text"], DateTime.parse(data["time"]));
      } else {
        print("reciever :$mounted");
        loadMessage("destination", data["text"], DateTime.parse(data["time"]));
      }
    });

    // recieve incoming message
    socket.on('chat message', (msg) {
      print(msg);
      loadMessage("destination", msg["message"], DateTime.now());
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: Duration(microseconds: 300), curve: Curves.easeOut);
        }
      });
    });
  }

  //sent message to socket and set message
  void sendMessage(String message, String sourceId, String targetId) {
    var now = DateTime.now();
    loadMessage("source", message, now);
    socket.emit("chat message",
        {"message": message, "source": sourceId, "targetId": widget.targetID});
  }

  //set the type of message and stored in message list variable
  void loadMessage(String type, String message, DateTime time) {
    MessageData messageData =
        MessageData(type: type, message: message, time: time);
    if (mounted) {
      setState(() {
        messages.add(messageData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    scrollToBottom();
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 5,
            title: Text(
              widget.chatName, //yay
              style: TextStyle(
                letterSpacing: 4,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                socket.onDisconnect((_) => print('Disconnect'));
                print("pop");
                Navigator.pop(context);
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return Home();
                // }));
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
            child: Column(
              children: [
                //message bubble
                Expanded(
                  // height: MediaQuery.of(context).size.height - 50,
                  child: ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return Container(height: 50);
                        }
                        if (messages[index].type == "source") {
                          return OwnMessageCard(
                              message: messages[index].message,
                              time: messages[index].time);
                        } else {
                          return ReplyCard(
                              message: messages[index].message,
                              time: messages[index].time);
                        }
                      }),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 100,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 100,
                              width: 100,
                              margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.multiline,
                                      controller: messageController,
                                      maxLines: 5,
                                      minLines: 1,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: " Type a message ...",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[500]),
                                        contentPadding: EdgeInsets.all(15),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.blue[600],
                                      child: IconButton(
                                        color: Colors.white,
                                        icon: Icon(Icons.send),
                                        onPressed: () {
                                          scrollController.animateTo(
                                              scrollController
                                                  .position.maxScrollExtent,
                                              duration:
                                                  Duration(microseconds: 300),
                                              curve: Curves.easeOut);
                                          sendMessage(messageController.text,
                                              employeeID, widget.targetID);
                                          messageController.clear();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void scrollToBottom() {
    Timer(
        Duration(seconds: 1),
        () => scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: Duration(microseconds: 300),
            curve: Curves.easeOut));
  }
}
