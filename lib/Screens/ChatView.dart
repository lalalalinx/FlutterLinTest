// ignore_for_file: file_names, prefer_const_literals_to_create_immutables

import 'package:chatki_project/Screens/chat/IndividualChat.dart';
import 'package:flutter/material.dart';
import 'package:chatki_project/chatData.dart';
import 'chat/ChatList.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  List<ChatData> chats = [
    ChatData(
        name: "Lin",
        isGroup: false,
        currentMessage: "Hi myself",
        time: "4:00",
        icon: "person.png"),
    ChatData(
        name: "Lin2",
        isGroup: true,
        currentMessage: "Hi myself2",
        time: "4:02",
        icon: "person.png"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return IndividualChat();
                }));
              },
        child: Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) => ChatList(
          chatData: chats[index],
        ),
      ),
    );
  }
}
