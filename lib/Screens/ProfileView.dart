// ignore_for_file: file_names, prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, dead_code

import 'dart:convert';
import 'dart:async';

import 'package:chatki_project/Model/ProfileData.dart';
import 'package:chatki_project/JSONtoDART/ShowProfile.dart';
import 'package:flutter/material.dart';
import 'package:chatki_project/Profile/EditProfile.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final storage = FlutterSecureStorage();
  late ProfileData stored;

  @override
  void initState() {
    super.initState();
  }

  Future<ProfileData> getProfileData() async {
    final token = await storage.read(key: "token");
    final refreshToken = await storage.read(key: "refreshToken");
    var res = await http.get(
      Uri.parse(
        'http://10.0.2.2:3000/profile/view',
      ),
      headers: <String, String>{
        'auth-token': token.toString(),
        'refresh-token': refreshToken.toString(),
      },
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EditProfile(profileDatas: stored);
          })).then((value) => setState(() {
                getProfileData();
              }));
        },
        child: Icon(Icons.edit),
      ),
      body: Column(children: [
        ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            Center(
              child: FutureBuilder(
                  future: getProfileData(),
                  builder: (context, AsyncSnapshot<ProfileData> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        height: 500,
                        child: Align(
                          alignment: Alignment.center,
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
                                  snapshot.data!.employeeID + ' ',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            DisplayNameAndLastName(snapshot),
                            SizedBox(height: 10.0),
                            Divider(thickness: 1),
                            SizedBox(height: 20.0),
                            DisplayEmailAndTel(snapshot),
                            SizedBox(height: 10.0),
                            Divider(thickness: 1),
                            SizedBox(height: 20.0),
                            DisplayAddress(snapshot),
                          ],
                        ),
                      );
                  }),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ]),
    );
  }

  Column DisplayAddress(AsyncSnapshot<ProfileData> snapshot) {
    return Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 40.0),
                                  staticText("City"),
                                  SizedBox(width: 49.0),
                                  infoText(snapshot.data!.city),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                children: [
                                  SizedBox(width: 40.0),
                                  staticText("Street"),
                                  SizedBox(width: 31.0),
                                  infoText(snapshot.data!.street),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                children: [
                                  SizedBox(width: 40.0),
                                  staticText("ZIP"),
                                  SizedBox(width: 50.0),
                                  infoText(snapshot.data!.zip),
                                ],
                              ),
                            ],
                          );
  }

  Column DisplayEmailAndTel(AsyncSnapshot<ProfileData> snapshot) {
    return Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 40.0),
                                  staticText("Email"),
                                  SizedBox(width: 25.0),
                                  infoText(snapshot.data!.email),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                children: [
                                  SizedBox(width: 40.0),
                                  staticText("Tel"),
                                  SizedBox(width: 46.0),
                                  infoText(snapshot.data!.tel),
                                ],
                              ),
                            ],
                          );
  }

  Column DisplayNameAndLastName(AsyncSnapshot<ProfileData> snapshot) {
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
                                  snapshot.data!.userFName +
                                      '  ' +
                                      snapshot.data!.userLName,
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

    Text infoText(String info) {
    return Text(
                                  info,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[900],
                                  ),
                                );
  }

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
}
