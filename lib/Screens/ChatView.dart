// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, prefer_const_constructors, avoid_print, sized_box_for_whitespace, non_constant_identifier_names
// Show ChatView
import 'dart:convert';
import 'dart:async';

import 'package:chatki_project/JSONtoDART/ShowChat.dart';
import 'package:chatki_project/Screens/chat/GroupChat.dart';
import 'package:chatki_project/Screens/chat/IndividualChat.dart';
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
  }

  //this function get list of current user chat history
  //if no chat history then it will display no chat
  Future getMutipleChatData() async {
    final token = await storage.read(key: "token");
    final refreshToken = await storage.read(key: "refreshToken");
    var res = await http.get(
      Uri.parse(
        'https://chattycat-heroku.herokuapp.com/chat',
      ),
      headers: <String, String>{
        'auth-token': token.toString(),
        'refresh-token': refreshToken.toString(),
      },
    );
    if (res.statusCode == 200) {
      final showChat = ShowChat.fromJson(jsonDecode(res.body));
      return showChat;
    } else {
      String noChat = "no";
      return noChat;
    }
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
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return WaitingAction();
                  } else if (snapshot.data == "no") {
                    return Text("No chat");
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
                                        InkWell(
                                          onTap: () {
                                            if (snapshot.data!.getAllChat[i]
                                                    .isGroup ==
                                                true) {
                                              print(snapshot
                                                  .data!.getAllChat[i].chatID);
                                              print(snapshot.data!.getAllChat[i]
                                                  .chatName);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return GroupChat(
                                                      chatID: snapshot.data!
                                                          .getAllChat[i].chatID,
                                                      chatName: snapshot
                                                          .data!
                                                          .getAllChat[i]
                                                          .chatName,
                                                    );
                                                  },
                                                ),
                                              ).then(
                                                (value) => setState(
                                                  () {
                                                    getMutipleChatData();
                                                  },
                                                ),
                                              );
                                            } else {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return IndividualChat(
                                                        chatID: snapshot
                                                            .data!
                                                            .getAllChat[i]
                                                            .chatID,
                                                        chatName: snapshot
                                                            .data!
                                                            .getAllChat[i]
                                                            .chatName,
                                                        targetID: snapshot
                                                            .data!
                                                            .getAllChat[i]
                                                            .employeeId);
                                                  },
                                                ),
                                              ).then(
                                                (value) => setState(
                                                  () {
                                                    getMutipleChatData();
                                                  },
                                                ),
                                              );
                                            }
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 5, bottom: 5),
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                backgroundColor: Colors.blue,
                                              ),
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
                                              subtitle: Text(
                                                snapshot.data!.getAllChat[i]
                                                    .previewChat[0].text,
                                              ),
                                              trailing: Text(
                                                snapshot.data!.getAllChat[i]
                                                        .previewChat[0].time.day
                                                        .toString() +
                                                    "/" +
                                                    snapshot
                                                        .data!
                                                        .getAllChat[i]
                                                        .previewChat[0]
                                                        .time
                                                        .month
                                                        .toString() +
                                                    "/" +
                                                    snapshot
                                                        .data!
                                                        .getAllChat[i]
                                                        .previewChat[0]
                                                        .time
                                                        .year
                                                        .toString() +
                                                    " " +
                                                    snapshot
                                                        .data!
                                                        .getAllChat[i]
                                                        .previewChat[0]
                                                        .time
                                                        .hour
                                                        .toString() +
                                                    ":" +
                                                    snapshot
                                                        .data!
                                                        .getAllChat[i]
                                                        .previewChat[0]
                                                        .time
                                                        .minute
                                                        .toString(),
                                                style: TextStyle(
                                                    color: Colors.grey[600]),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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

////
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
            Text(
              'L o a d i n g . . .',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
