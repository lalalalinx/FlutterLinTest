// ignore_for_file: file_names, prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, dead_code

import 'dart:convert';
import 'dart:async';

import 'package:chatki_project/Model/ProfileData.dart';
import 'package:chatki_project/Model/ProfileUserData.dart';
import 'package:chatki_project/demoo/ShowProfile.dart';
import 'package:flutter/material.dart';
import 'package:chatki_project/Profile/ProfildWidget.dart';
import 'package:chatki_project/Profile/EditProfile.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
    storedData();
    super.initState();
  }

  void storedData() async {
    super.initState();
    stored = await getProfileData().whenComplete(() {
      setState(() {});
    });
  }

  Future<ProfileData> getProfileData() async {
    final token = await storage.read(key: "token");
    final refreshToken = await storage.read(key: "refreshToken");
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    var res = await http.get(
      Uri.parse(
        'http://10.0.2.2:4000/profile/view',
      ),
      headers: <String, String>{
        'auth-token': token.toString(),
        'refresh-token': refreshToken.toString(),
      },
    );
    var body = res.body;
    final showProfile = ShowProfile.fromJson(jsonDecode(body));
    String output = res.body;
    if (res.statusCode == 200) {
      print("helli");
    } else {
      print(output);
    }

    ProfileData profileDatas = ProfileData(
        employeeID: showProfile.view[0],
        email: showProfile.view[1],
        tel: showProfile.view[2],
        userFName: showProfile.view[3],
        userLName: showProfile.view[4],
        city: showProfile.view[5],
        street: showProfile.view[6],
        zip: showProfile.view[7]);

    // ProfileData userData = ProfileData(
    //   showProfile.view[0],
    //   showProfile.view[1],
    //   showProfile.view[2],
    //   showProfile.view[3],
    //   showProfile.view[4],
    //   showProfile.view[5],
    //   showProfile.view[6],
    //   showProfile.view[7]);
    // profileDatas.add(userData);

    prefs.setString('employeeID', profileDatas.employeeID);
    print(showProfile.view.length);
    return profileDatas;
  }

  Future<String?> readToken() async {
    final tokenStore = await storage.read(key: "token");
    final refreshTokenStore = await storage.read(key: "refreshToken");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return EditProfile();
            }));
          },
          child: Icon(Icons.edit),
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Center(
              child: FutureBuilder(
                  future: getProfileData(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: Text('Loading . . .'),
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
                                        image: NetworkImage('https://files.eventpass.co/eventpass-api/files/1629791258776-46229AD3-D72F-483A-B699-7D7C49B3946B.jpeg'),
                                      ),
                                    ),
                                  ),
                              ),),
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              color: Colors.grey[900],
                              height: 50,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  stored.employeeID+' ',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                                // Row(
                                //   children: [
                                //     SizedBox(width: 40.0),
                                //     Text(
                                //       'Employee ID :',
                                //       style: TextStyle(
                                //         fontSize: 20,
                                //         fontWeight: FontWeight.w300,
                                //         color: Colors.red[400],
                                //       ),
                                //     ),
                                //     SizedBox(width: 10.0),
                                //     Text(
                                //       stored.employeeID,
                                //       style: TextStyle(
                                //         fontSize: 30,
                                //         fontWeight: FontWeight.w300,
                                //         color: Colors.white,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                            //   ),
                            // ),

                            SizedBox(height: 20.0),
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
                            SizedBox(height: 10.0),
                            Divider(thickness: 1),

                            SizedBox(height: 20.0),
                            Row(
                              children: [
                                SizedBox(width: 40.0),
                                Text(
                                  'Email :',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                SizedBox(width: 25.0),
                                Text(
                                  stored.email,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              children: [
                                SizedBox(width: 40.0),
                                Text(
                                  'Tel :',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                SizedBox(width: 46.0),
                                Text(
                                  stored.tel,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Divider(thickness: 1),
                            SizedBox(height: 20.0),
                            Row(
                              children: [
                                SizedBox(width: 40.0),
                                Text(
                                  'City',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                SizedBox(width: 49.0),
                                Text(
                                  stored.city,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              children: [
                                SizedBox(width: 40.0),
                                Text(
                                  'Street',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                SizedBox(width: 31.0),
                                Text(
                                  stored.street,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              children: [
                                SizedBox(width: 40.0),
                                Text(
                                  'ZIP',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                SizedBox(width: 50.0),
                                Text(
                                  stored.zip,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ],
                            ),
                            // Center(
                            //   child: Text('Employee ID ',
                            //       style: TextStyle(
                            //         fontSize: 20,
                            //         fontWeight: FontWeight.w500,
                            //         color: Colors.grey[900],
                            //       ),),
                            // ),
                            // //--
                            // Center(
                            //   child: Text(
                            //     stored.employeeID,
                            //     style: TextStyle(
                            //       fontSize: 30,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      );
                  }),
            ),

            //   Text(
            //     'stored.employeeID',
            //     style: TextStyle(
            //       fontSize: 30,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),

            // ProfileWidget(
            //   image: user.image,
            //   onClicked: () async {},
            // ),
            const SizedBox(height: 24),
            //buildName(user),
          ],
        ),
      ),
    );

    // Widget buildName(user) => Scaffold(
    //       appBar: AppBar(
    //         title: Text('Your Profile'),
    //         centerTitle: true,
    //         elevation: 0,
    //       ),
    //       body: Container(
    //         child: Card(
    //           child: FutureBuilder(
    //             future: getProfileData(),
    //             builder: (context, snapshot) {
    //               if (snapshot.data == null) {
    //                 return Container(
    //                   child: Center(
    //                     child: Text('Loading . . .'),
    //                   ),
    //                 );
    //               } else
    //                 return Center(
    //                   child: Text(stored.userFName),
    // );
    // ignore: curly_braces_in_flow_control_structures
    // return ListView.builder(
    //     //itemBuilder: snapshot.data.length,
    //     itemBuilder: (context, i) {
    //       return ListTile(
    //         title: Text(snapshot.data[0]),
    //         subtitle: Text(snapshot.data[3]),
    //         trailing: Text(snapshot.data[4]),
    //       );
    //     });
    //         },
    //       ),
    //     ),
    //   ),
    // );

    Container(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text('Employee ID ',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[900],
                )),
          ),
          //--
          Center(
            child: Text(
              stored.employeeID,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            'Name - Surname',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple),
          ),
          const SizedBox(height: 5),
          Text(
            stored.userFName + ' - ' + stored.userLName,
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          Text(
            'Email',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple),
          ),
          const SizedBox(height: 5),
          Text(
            stored.email,
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          Text(
            'Tel',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple),
          ),
          const SizedBox(height: 5),
          Text(
            stored.tel,
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          Text(
            'City - Street - ZIP',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple),
          ),
          const SizedBox(height: 5),
          Text(
            stored.city + ' - ' + stored.street + ' - ' + stored.zip,
            style: TextStyle(fontSize: 18),
          ),
          //--
        ],
      ),
    );
  }
}
