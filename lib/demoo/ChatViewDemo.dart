// ignore_for_file: file_names, prefer_const_literals_to_create_immutables

import 'package:chatki_project/Screens/chat/IndividualChat.dart';
import 'package:chatki_project/demoo/ChatListDemo.dart';
import 'package:chatki_project/demoo/CustomCard.dart';
import 'package:flutter/material.dart';
import 'package:chatki_project/Model/chatData.dart';

class ChatViewDemo extends StatefulWidget {
  const ChatViewDemo({Key? key,required this.chatdata,required this.sourceChat}) : super(key: key);
  final List<ChatData> chatdata;
  final ChatData sourceChat;

  @override
  _ChatViewDemoState createState() => _ChatViewDemoState();
}

class _ChatViewDemoState extends State<ChatViewDemo> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return IndividualChat();
                // }));
              },
        child: Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: widget.chatdata.length,
        itemBuilder: (context, index) => CustomCard(
          chatData: widget.chatdata[index],
          sourceChat: widget.sourceChat,
        ),
      ),
    );
  }
}
