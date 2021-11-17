// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, prefer_const_constructors, avoid_print
import 'dart:convert';
import 'dart:async';

import 'package:chatki_project/JSONtoDART/ShowChat.dart';
import 'package:chatki_project/Screens/chat/IndividualChat.dart';
import 'package:flutter/material.dart';
import 'package:chatki_project/Model/MutipleChatData.dart';
import 'Others/Otherprofile.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final storage = FlutterSecureStorage();
  late final ShowChat multipleChatdd;

  @override
  void initState() {
    getMutipleChatData();
    super.initState();
  }

  Future<ShowChat> getMutipleChatData() async {
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
    final showChat = ShowChat.fromJson(jsonDecode(res.body));
    if (res.statusCode == 200) {
      print('Chat'); 
    } else {
      String output = res.body;
      print(output);
    }
    return showChat;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Scaffold(
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Center(
              child: FutureBuilder(
                future: getMutipleChatData(),
                builder: (context, AsyncSnapshot<ShowChat> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return WaitingAction();
                  } else
                    return Center(
                      child: Column(
                        children: [
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.getAllChat.length,
                            itemBuilder: (context, i) {
                              return Column(
                                children: [
                                  Card(
                                      color: Colors.white,
                                      margin: EdgeInsets.only(bottom: 5),
                                      child: Column(
                                        children: [
                                          //padding: EdgeInsets.only(left: 10,right: 10),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return IndividualChat(
                                                    chatID: snapshot.data!
                                                        .getAllChat[i].chatId,
                                                        chatName: snapshot.data!
                                                        .getAllChat[i].chatName,
                                                        targetID: snapshot.data!.getAllChat[i].employeeId);
                                              }));
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: ListTile(
                                                leading: CircleAvatar(backgroundColor: Colors.blue,),
                                                title: Row(
                                                  children: [
                                                  
                                                    Text(
                                                        snapshot
                                                            .data!
                                                            .getAllChat[i]
                                                            .chatName,
                                                        style: TextStyle(
                                                            fontSize: 18)),
                                                  ],
                                                ),
                                                subtitle: Text(snapshot.data!.getAllChat[i].previewChat[0].text,),
                                                trailing: Text(
                                                  snapshot
                                                      .data!.getAllChat[i].previewChat[0].time.toString(),
                                                  style: TextStyle(
                                                      color: Colors.grey[600]),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                  //Divider(thickness: 1),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Container WaitingAction() {
    return Container(
                      height: 500,
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 200.0,
                            ),
                            CircularProgressIndicator(),
                            SizedBox(
                              height: 30.0,
                            ),
                            // ignore: prefer_const_constructors
                            Text(
                              'L o a d i n g . . .',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ));
  }
}
