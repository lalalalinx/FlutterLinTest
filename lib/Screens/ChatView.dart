// ignore_for_file: file_names, prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'dart:async';

import 'package:chatki_project/Model/MutipleChatData.dart';
import 'package:chatki_project/Screens/chat/IndividualChat.dart';
import 'package:flutter/material.dart';
import 'package:chatki_project/JSONtoDART/MutipleChatjson.dart';
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
  //late MutipleChatData stored;

    @override
  void initState() {
    storedData();
    super.initState();
  }

  void storedData() async {
    super.initState();
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
    var body = res.body;
    final mutipleChatjson = MutipleChatjson.fromJson(jsonDecode(body));
    String output = res.body;
    if (res.statusCode == 200) {
      print("ok");
    } else {
      print(output);
    }
    // var jsonData = jsonDecode(body);
    // List<MutipleChatData> mutipleChats = [];
    // for(var u in jsonData) {
    //   MutipleChatData mutipleChatData = MutipleChatData(u["currentMessage"],u["time"],u["username"],u["chatRoomID"]);
    //   mutipleChats.add(mutipleChatData);
    // }

    // print(mutipleChats.length);
    // return mutipleChats;

    // MutipleChatData mutipleChatDatas = MutipleChatData(
    //     currentMessage: mutipleChatjson.mutipleChatjsonSet[0][0],
    //     time: mutipleChatjson.mutipleChatjsonSet[0][1],
    //     username: mutipleChatjson.mutipleChatjsonSet[0][2],
    //     chatRoomID: mutipleChatjson.mutipleChatjsonSet[0][3]);

    // print(mutipleChatjson.mutipleChatjsonSet.length);
    // return mutipleChatDatas;
  }

  Future<String?> readToken() async {
    final tokenStore = await storage.read(key: "token");
    final refreshTokenStore = await storage.read(key: "refreshToken");
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
