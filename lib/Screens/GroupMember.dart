// ignore_for_file: file_names

import 'package:chatki_project/JSONtoDART/ShowGroupMember.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class GroupMember extends StatefulWidget {
  const GroupMember({Key? key, required this.chatID}) : super(key: key);
  final String chatID;

  @override
  _GroupMemberState createState() => _GroupMemberState();
}

class _GroupMemberState extends State<GroupMember> {
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    showGroupMember();
    super.initState();
  }

  Future showGroupMember() async {
    final token = await storage.read(key: "token");
    final refreshToken = await storage.read(key: "refreshToken");
    var res = await http.post(
        Uri.parse(
          'http://10.0.2.2:3000/group',
        ),
        headers: <String, String>{
          'auth-token': token.toString(),
          'refresh-token': refreshToken.toString(),
        },
        body: <String, String>{
          'chatID': widget.chatID
        });
    if (res.statusCode == 200) {
      final showGroupMember = showGroupMemberFromJson(res.body);
      //loop for testing
      for (var member in showGroupMember) {
        print(member.userName);
      }
      return showGroupMember;
    } else {
      print(res.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
