// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors

// sender , reciever

import 'dart:convert';

import 'package:chatki_project/Model/MessageData.dart';
import 'package:chatki_project/Model/chatData.dart';
import 'package:chatki_project/Screens/chat/OwnMessageCard.dart';
import 'package:chatki_project/Screens/chat/ReplyCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:http/http.dart' as http;

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

  TextEditingController messageController = TextEditingController();
  @override
  void initState() {
    connectSocket();
    super.initState();
  }

  Future connectSocket() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    socket = io(
        'http://10.0.2.2:3000/',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .build());
    socket.connect();
    employeeID = prefs.getString('employeeID')!;
    socket.emit("signin", {employeeID, widget.chatID, -1});
    socket.on('loadUniqueChat', (data) {
      print(data);
      var username = prefs.getString('username');
      if(data["sender"] == username) {
        setMessage("source", data["text"], DateTime.parse(data["time"]));
      }
      else{
        setMessage("destination", data["text"], DateTime.parse(data["time"]));
      }
      
    });
    socket.onConnect((data) {
      print("Connected");
      socket.on('chat message', (msg) {
        print(msg);
        setMessage("destination", msg["message"], DateTime.now());
      });
    });
  }

  void sendMessage(String message, String sourceId, String targetId) {
    var now = DateTime.now();
    setMessage("source", message, now);
    socket.emit("chat message",
        {"message": message, "source": sourceId, "targetId": widget.targetID});
  }


  void setMessage(String type, String message, DateTime time) {
    MessageData messageData =
        MessageData(type: type, message: message, time: time);
    setState(() {
      messages.add(messageData);
    });
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
              widget.chatName, //yay
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
                socket.onDisconnect((_) => print('Disconnect'));
                print("pop");
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
                //message bubble
                Container(
                  height: MediaQuery.of(context).size.height - 50,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
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
                  child: Row(
                    children: [
                      // Text message field
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
                            controller: messageController,
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
                      // sent button
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
                              onPressed: () {
                                sendMessage(messageController.text, employeeID,
                                    widget.targetID);
                                messageController.clear();
                              },
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
