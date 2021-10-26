// ignore_for_file: file_names, prefer_const_constructors, non_constant_identifier_names

import 'package:chatki_project/Screens/ChatView.dart';
import 'package:chatki_project/Screens/chat/IndividualChat.dart';
import 'package:chatki_project/demoo/IndividualPageDemo.dart';
import 'package:flutter/material.dart';
import 'package:chatki_project/Model/chatData.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.chatData, required this.sourceChat})
      : super(key: key);
  final ChatData chatData;
  final ChatData sourceChat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (contex) => IndividualPageDemo(
                    chatData: chatData, sourceChat: sourceChat)));
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
            child: Divider(
              thickness: 0.7,
            ),
          )
        ],
      ),
    );
  }
}
