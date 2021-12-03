// ignore_for_file: file_names, prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, dead_code, non_constant_identifier_names
// other profile view
import 'dart:convert';
import 'dart:async';
import 'package:chatki_project/JSONtoDART/ShowOtherChat.dart';
import 'package:chatki_project/Screens/chat/IndividualChat.dart';
import 'package:flutter/material.dart';
import 'package:chatki_project/Model/ProfileData.dart'; //list data ของ user
import 'package:chatki_project/JSONtoDART/ShowProfile.dart'; //๋JSON

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class OtherProfile extends StatefulWidget {
  const OtherProfile({Key? key, required this.targetID, required this.chatName})
      : super(key: key);
  final String targetID;
  final String chatName;

  @override
  _OtherProfileState createState() => _OtherProfileState();
}

class _OtherProfileState extends State<OtherProfile> {
  final storage = FlutterSecureStorage();
  late ProfileData stored;

  @override
  void initState() {
    storedData();
    super.initState();
  }

  void storedData() async {
    super.initState();
    stored = await getProfileData().whenComplete(() {
      setState(() {});
    });
  }

  //This function get a target user information via API
  //return proflie class data
  Future getProfileData() async {
    final token = await storage.read(key: "token");
    final refreshToken = await storage.read(key: "refreshToken");
    var res = await http.post(
        Uri.parse(
          'https://chattycat-heroku.herokuapp.com/profile/viewOther',
        ),
        headers: <String, String>{
          'auth-token': token.toString(),
          'refresh-token': refreshToken.toString(),
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'targetID': widget.targetID,
        });
    final showProfile = ShowProfile.fromJson(jsonDecode(res.body));
    String output = res.body;
    if (res.statusCode == 200) {
      ProfileData profileDatas = ProfileData(
          employeeID: showProfile.view[0],
          email: showProfile.view[1],
          tel: showProfile.view[2],
          userFName: showProfile.view[3],
          userLName: showProfile.view[4],
          city: showProfile.view[5],
          street: showProfile.view[6],
          zip: showProfile.view[7]);
      return profileDatas;
    } else {
      print(output);
    }
  }

  Future sentToChat() async {
    final token = await storage.read(key: "token");
    final refreshToken = await storage.read(key: "refreshToken");
    var res = await http.post(
        Uri.parse(
          "https://chattycat-heroku.herokuapp.com/home/chat",
        ),
        headers: <String, String>{
          'auth-token': token.toString(),
          'refresh-token': refreshToken.toString(),
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'receiverID': widget.targetID,
          'chatName': widget.chatName
        });

    if (res.statusCode == 200) {
      final showOtherChat = showOtherChatFromJson(res.body);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return IndividualChat(
                chatID: showOtherChat.chatId,
                chatName: showOtherChat.chatName,
                targetID: widget.targetID); //<----------ไปหน้าแชทคนนั้นๆ
          },
        ),
      );
    } else {
      String error = res.body;
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final shape = StadiumBorder();
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[900],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Scaffold(
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Center(
                child: FutureBuilder(
                  future: getProfileData(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        height: 500,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'L o a d i n g . . .',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                    } else
                      return Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: Container(
                                color: Colors.grey[900],
                              ),
                            ),
                            Container(
                              color: Colors.grey[900],
                              child: Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: Center(
                                  child: Container(
                                    width: 170,
                                    height: 170,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[900],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'https://files.eventpass.co/eventpass-api/files/1629791258776-46229AD3-D72F-483A-B699-7D7C49B3946B.jpeg'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              color: Colors.grey[900],
                              height: 50,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  stored.employeeID + ' ',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            DisplayOtherNandL(),
                            SizedBox(height: 10.0),
                            Divider(thickness: 1),
                            SizedBox(height: 20.0),
                            DisplayOtherEmailAndTel(),
                            SizedBox(height: 10.0),
                            Divider(thickness: 1),
                            SizedBox(height: 20.0),
                            DisplayOtherAddress(),
                            Padding(
                              //ปุ่ม 'chat' ด้านล่าง
                              padding: const EdgeInsets.symmetric(
                                  vertical: 30.0, horizontal: 110),
                              child: Container(
                                decoration: ShapeDecoration(
                                  shape: shape,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.blue,
                                      Colors.deepPurple,
                                    ],
                                  ),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    sentToChat();
                                  },
                                  child: Text(
                                    'C h a t',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    //primary: Colors.deepPurple[700],
                                    fixedSize: const Size(200, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    primary: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  //show address section
  Column DisplayOtherAddress() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 40.0),
            staticText("City"),
            SizedBox(width: 49.0),
            infoOtherText(stored.city),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            SizedBox(width: 40.0),
            staticText("Street"),
            SizedBox(width: 31.0),
            infoOtherText(stored.street),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            SizedBox(width: 40.0),
            staticText("ZIP"),
            SizedBox(width: 50.0),
            infoOtherText(stored.zip),
          ],
        ),
      ],
    );
  }

  //show email section
  Column DisplayOtherEmailAndTel() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 40.0),
            staticText("Email"),
            SizedBox(width: 25.0),
            infoOtherText(stored.email),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            SizedBox(width: 40.0),
            staticText("Tel"),
            SizedBox(width: 46.0),
            infoOtherText(stored.tel),
          ],
        ),
      ],
    );
  }

  //show name and surname section
  Column DisplayOtherNandL() {
    return Column(
      children: [
        Center(
          //padding: EdgeInsets.only(left: 40),
          child: Text(
            'Name - Surname',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.deepPurple,
            ),
          ),
        ),
        SizedBox(height: 10),
        Center(
            //padding: EdgeInsets.only(left: 125),
            child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Text(
            stored.userFName + '  ' + stored.userLName,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: Colors.grey[900],
            ),
          ),
        )),
      ],
    );
  }

  // set text style
  Text staticText(String text) {
    return Text(
      '$text :',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.deepPurple,
      ),
    );
  }

  // set text style
  Text infoOtherText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Colors.grey[900],
      ),
    );
  }
}
