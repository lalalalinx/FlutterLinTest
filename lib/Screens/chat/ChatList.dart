// ignore_for_file: file_names, prefer_const_constructors, non_constant_identifier_names

import 'package:chatki_project/Screens/ChatView.dart';
import 'package:flutter/material.dart';
import 'package:chatki_project/Model/chatData.dart';
import 'IndividualChat.dart';

class ChatList extends StatelessWidget {
  const ChatList({Key? key, required this.chatData}) : super(key: key);
  final ChatData chatData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context, MaterialPageRoute(builder: (contex) => IndividualChat(chatData:chatData))
        );
      },
      child: Column(
        children: [
          ListTile(
      leading: CircleAvatar(
        radius: 25,
      ),
      title: Text(
        chatData.name,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        chatData.currentMessage,
        style: TextStyle(
          fontSize: 13,
        ),
      ),
      trailing: Text(chatData.time),
    ),
    Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Divider(thickness: 0.7,
      ),
    )
        ],
      ),
    );

  }
}
