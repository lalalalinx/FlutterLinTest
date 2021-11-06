// ignore_for_file: file_names, prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'dart:async';

import 'package:chatki_project/JSONtoDART/mutipleChatjson.dart';
import 'package:chatki_project/Screens/chat/IndividualChat.dart';
import 'package:flutter/material.dart';
//import 'package:chatki_project/Model/chatData.dart';
import 'chat/ChatList.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final storage = FlutterSecureStorage();
  late final MultipleChatList multipleChatList;

    @override
  void initState() {
    getMutipleChatData();
    super.initState();
  }

  void storedData() async {
    //stored = await getMutipleChatData().whenComplete(() {
    //   setState(() {});
    // });
  }

  Future getMutipleChatData() async {
    final token = await storage.read(key: "token");
    final refreshToken = await storage.read(key: "refreshToken");
    var res = await http.get(
      Uri.parse(
        'http://10.0.2.2:4000/chat',
      ),
      headers: <String, String>{
        'auth-token': token.toString(),
        'refresh-token': refreshToken.toString(),
      },
    );
    multipleChatList = multipleChatListFromJson(res.body);
    if (res.statusCode == 200) {
      print(multipleChatList.getAllChat[0].chatName); //ตัวอย่างใช้งาน
    } else {
      String output = res.body;
      print(output);
    }
  }


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
      // body: ListView.builder(
      //   itemCount: set.length,
      //   itemBuilder: (context, index) => ChatList(
      //     chatData: set[index],
      //   ),
      // ),
    );
  }
}
