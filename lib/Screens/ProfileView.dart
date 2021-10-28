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
    var token = readToken();
    var tokenString = token.toString();
    final tokenStore = await storage.read(key: "token");
    var res = await http.get(
      Uri.parse(
        'http://10.0.2.2:3000/profile/view',
      ),
      headers: <String, String>{'auth-token': tokenStore.toString()},
    );
    var body = res.body;
    final showProfile = ShowProfile.fromJson(jsonDecode(body));
    String output = res.body;
    if (res.statusCode == 200) {
      print("ok");
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

    print(showProfile.view.length);
    return profileDatas;
  }

  Future<String?> readToken() async {
    final tokenStore = await storage.read(key: "token");
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
              child: 
              FutureBuilder(
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
                      child: Text(stored.userFName),
                                  );
                }
              ),
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
