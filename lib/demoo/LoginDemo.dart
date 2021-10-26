// ignore_for_file: file_names

import 'package:chatki_project/demoo/ChatListDemo.dart';
import 'package:chatki_project/demoo/HomeDemo.dart';
import 'package:flutter/material.dart';
import 'package:chatki_project/Model/chatData.dart';

class LoginDemo extends StatefulWidget {
  const LoginDemo({ Key? key }) : super(key: key);

  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  late ChatData sourceChat;
  List<ChatData> chatmodels = [
    ChatData(
        name: "jeremiee",
        isGroup: false,
        currentMessage: "Hi myself",
        time: "4:00",
        icon: "person.png",
        id: 62070503425),
    ChatData(
        name: "Lin",
        isGroup: false,
        currentMessage: "Hi lin",
        time: "13:02",
        icon: "person.png",
        id: 62070503406),
    ChatData(
        name: "Doon",
        isGroup: false,
        currentMessage: "Hi doon",
        time: "18:02",
        icon: "person.png",
        id: 62070503421),
    ChatData(
        name: "jade",
        isGroup: false,
        currentMessage: "Hi jade",
        time: "0:02",
        icon: "person.png",
        id: 62070503409),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatmodels.length,
        itemBuilder: (context, index) => InkWell(
          onTap: (){
            sourceChat = chatmodels.removeAt(index);
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (builder) => HomeDemo(
              chatdata:chatmodels,
              sourceChat: sourceChat,
            )));
          },
          child: ChatListDemo(
            chatData: chatmodels[index],
          ),
        ),
      ),
    );
  }
}