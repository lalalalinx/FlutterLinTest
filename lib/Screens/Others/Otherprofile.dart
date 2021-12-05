// ignore_for_file: file_names, prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, dead_code, non_constant_identifier_names
// other profile view
import 'dart:convert';
import 'dart:async';
import 'package:chatki_project/JSONtoDART/ShowOtherChat.dart';
import 'package:chatki_project/Screens/chat/IndividualChat.dart';
import 'package:flutter/material.dart';
import 'package:chatki_project/Model/ProfileData.dart'; //list data ของ user
import 'package:chatki_project/JSONtoDART/ShowProfile.dart'; //๋JSON
import 'package:chatki_project/Components.dart';
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
  Future<ProfileData> getProfileData() async {
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
      stored = ProfileData(
          employeeID: showProfile.view[0],
          email: showProfile.view[1],
          tel: showProfile.view[2],
          userFName: showProfile.view[3],
          userLName: showProfile.view[4],
          city: showProfile.view[5],
          street: showProfile.view[6],
          zip: showProfile.view[7]);
      
    } else {
      print(output);
    }
    return stored;
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
                targetID: widget.targetID);
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
                  builder: (context, AsyncSnapshot<ProfileData> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Components.waitingAction();
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
                            Components.ContainerPersonProfile(),
                            DisplayEmployeeID(snapshot),
                            SizedBox(height: 20.0),
                            DisplayOtherNandL(snapshot),
                            SizedBox(height: 10.0),
                            Divider(thickness: 1),
                            SizedBox(height: 20.0),
                            DisplayOtherEmailAndTel(snapshot),
                            SizedBox(height: 10.0),
                            Divider(thickness: 1),
                            SizedBox(height: 20.0),
                            DisplayOtherAddress(snapshot),
                            Padding(
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
  Column DisplayOtherAddress(AsyncSnapshot<ProfileData> snapshot) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 40.0),
            Components.titleText("City"),
            SizedBox(width: 49.0),
            Components.infoText(snapshot.data!.city),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            SizedBox(width: 40.0),
            Components.titleText("Street"),
            SizedBox(width: 31.0),
            Components.infoText(snapshot.data!.street),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            SizedBox(width: 42.0),
            Components.titleText("ZIP"),
            SizedBox(width: 50.0),
            Components.infoText(snapshot.data!.zip),
          ],
        ),
      ],
    );
  }

  //show employee's ID section
  Container DisplayEmployeeID(AsyncSnapshot<ProfileData> snapshot) {
    return Container(
      alignment: Alignment.topRight,
      color: Colors.grey[900],
      height: 50,
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          snapshot.data!.employeeID + ' ',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  //show email section
  Column DisplayOtherEmailAndTel(AsyncSnapshot<ProfileData> snapshot) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 40.0),
            Components.titleText("Email"),
            SizedBox(width: 25.0),
            Components.infoText(snapshot.data!.email),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            SizedBox(width: 40.0),
            Components.titleText("Tel"),
            SizedBox(width: 46.0),
            Components.infoText(snapshot.data!.tel),
          ],
        ),
      ],
    );
  }

  //show name and surname section
  Column DisplayOtherNandL(AsyncSnapshot<ProfileData> snapshot) {
    return Column(
      children: [
        Center(
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
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Text(
              snapshot.data!.userFName + '  ' + snapshot.data!.userLName,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: Colors.grey[900],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
