// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors

// Not in use

import 'dart:async';

import 'package:chatki_project/Model/MessageData.dart';
import 'package:chatki_project/Screens/chat/OwnMessageCard.dart';
import 'package:chatki_project/Screens/chat/ReplyCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';

class GroupChat extends StatefulWidget {
  const GroupChat({
    Key? key,
    required this.chatID,
    required this.chatName,
  }) : super(key: key);
  final String chatID;
  final String chatName;

  @override
  _GroupChatState createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  late Socket socket;
  final storage = FlutterSecureStorage();
  List<MessageData> messages = [];
  late String employeeID;
  late String username;

  //controller
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    connectSocket();
    super.initState();
  }

  // connect to socketio and recieve previous message and incoming message
  Future connectSocket() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    socket = io(
        'https://chattycat-heroku.herokuapp.com',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .build());
    socket.connect();
    employeeID = prefs.getString('employeeID')!;
    username = prefs.getString('username')!;
    socket.emit("signin", {employeeID, widget.chatID, -1});
    //load previous message
    socket.on('loadUniqueChat', (data) {
      if (data["sender"] == username) {
        setMessage("source", data["text"], DateTime.parse(data["time"]));
      } else {
        setMessage("destination", data["text"], DateTime.parse(data["time"]));
      }
    });
    //recieve incoming message
    socket.onConnect((data) {
      print("Connected");
      socket.on('group message', (msg) {
        print(msg);
        if (msg["sender"] != username) {
          setMessage("destination", msg["message"], DateTime.now());
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: Duration(microseconds: 300), curve: Curves.easeOut);
        }
      });
    });
  }

  //sent message to socket and set message
  void sendMessage(String message, String sender) {
    var now = DateTime.now();
    setMessage("source", message, now);
    socket.emit("group message", {"message": message, "sender": sender});
  }

  //set the type of message and stored in message list variable
  void setMessage(String type, String message, DateTime time) {
    MessageData messageData =
        MessageData(type: type, message: message, time: time);
    setState(() {
      messages.add(messageData);
    });
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 1),
        () => scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
            ));
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
                socket.emit('disconnect');
                socket.onDisconnect((_) => print('Disconnect'));
                print("pop");
                messages.clear();
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
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                //message bubble
                Expanded(
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
                                    textAlignVertical: TextAlignVertical.center,
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
                                        sendMessage(
                                            messageController.text, username);
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
