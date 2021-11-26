// ignore_for_file: file_names, prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'package:chatki_project/JSONtoDART/ShowGroupMember.dart';
import 'package:chatki_project/Screens/Others/Otherprofile.dart';
import 'package:chatki_project/Screens/chat/GroupChat.dart';
import 'package:chatki_project/Screens/createGroup/AddMember.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class GroupProfile extends StatefulWidget {
  const GroupProfile({Key? key, required this.chatID, required this.groupName})
      : super(key: key);
  final String chatID;
  final String groupName;

  @override
  _GroupProfileState createState() => _GroupProfileState();
}

class _GroupProfileState extends State<GroupProfile> {
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    getGroupProfile();
    super.initState();
  }

  Future<List> getGroupProfile() async {
    final token = await storage.read(key: "token");
    final refreshToken = await storage.read(key: "refreshToken");
    var res = await http.post(
        Uri.parse(
          'https://chattycat-heroku.herokuapp.com/group',
        ),
        headers: <String, String>{
          'auth-token': token.toString(),
          'refresh-token': refreshToken.toString(),
        },
        body: <String, String>{
          'chatID': widget.chatID
        });
    final showGroupMember = showGroupMemberFromJson(res.body);
    if (res.statusCode == 200) {
      //loop for testing
      for (var member in showGroupMember) {
        print(member.userName);
      }
    } else {
      print(res.body);
    }
    return showGroupMember;
  }

//////// รอกด

  @override
  final shape = StadiumBorder();
  Widget build(BuildContext context) {
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
            )),
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
                    future: getGroupProfile(),
                    builder: (context, AsyncSnapshot<List> snapshot) {
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
                                //height: 200.0,
                                child: Container(
                                  color: Colors.grey[900],
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 170,
                                            height: 170,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[900],
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    'https://cdn.shopify.com/s/files/1/0050/3349/2553/articles/Alpacas_in_field_22_N21_2000x.jpg?v=1589368550'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20.0),
                                          Container(
                                            alignment: Alignment.center,
                                            color: Colors.grey[900],
                                            child: Row(
                                              children: [
                                                SizedBox(width: 40.0),
                                                Text(
                                                  'Group Name :',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topCenter,
                                            color: Colors.grey[900],
                                            height: 30,
                                            child: Text(
                                              widget.groupName,
                                              style: TextStyle(
                                                fontSize: 23,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.orange[300],
                                              ),
                                            ),
                                          ), /////////
                                          Padding(
                                            //ปุ่ม 'chat'--------------------------
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20.0,
                                                horizontal: 110),
                                            child: Container(
                                              decoration: ShapeDecoration(
                                                shape: shape,
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.orange,
                                                    Colors.pink,
                                                  ],
                                                ),
                                              ),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return GroupChat(
                                                      chatID: widget.chatID,
                                                      chatName: widget.groupName,
                                                      );
                                                }));
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
                                                  fixedSize:
                                                      const Size(200, 50),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  tapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  primary: Colors.transparent,
                                                  shadowColor:
                                                      Colors.transparent,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Row(
                                children: [
                                  SizedBox(width: 30.0),
                                  Icon(Icons.group, size: 25),
                                  SizedBox(width: 10.0),
                                  Text(
                                    'Member :',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  //SizedBox(width: 10.0),
                                  addMemberButton(context),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, i) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Card(
                                            shape: shape,
                                            color: Colors.white,
                                            margin: EdgeInsets.all(5),
                                            child: Column(
                                              children: [
                                                //padding: EdgeInsets.only(left: 10,right: 10),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return OtherProfile(
                                                          targetID: snapshot
                                                              .data![i]
                                                              .employeeId,
                                                          chatName: snapshot
                                                              .data![i]
                                                              .userName);
                                                    }));
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    child: ListTile(
                                                      title: Row(
                                                        children: [
                                                          Container(
                                                            width: 50,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .grey[600],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Text(
                                                              snapshot.data![i]
                                                                  .userName,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      18)),
                                                        ],
                                                      ),
                                                      trailing: Text(
                                                        snapshot.data![i]
                                                            .employeeId,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[600]),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                    }),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Container addMemberButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 85),
      width: 136,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddMember(chatID:widget.chatID,groupName:widget.groupName);
          }));
          // <-----------add MORE here
        },
        child: Row(
          children: [
            Text(
              'Add Member ',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            Icon(Icons.add_circle_outline_sharp, size: 20),
          ],
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.lightBlue,
          fixedSize: const Size(400, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
