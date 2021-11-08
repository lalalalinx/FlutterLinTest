// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, sized_box_for_whitespace, prefer_const_constructors, duplicate_ignore

import 'dart:convert';

import 'package:chatki_project/JSONtoDART/HomeJson.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:chatki_project/Model/HomeViewData.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final storage = FlutterSecureStorage();
  late final HomeViewData homedd;

  @override
  void initState() {
    super.initState();
  }

  Future<HomeViewData> getHomeData() async {
    final token = await storage.read(key: "token");
    final refreshToken = await storage.read(key: "refreshToken");
    var res = await http.get(
      Uri.parse(
        'http://10.0.2.2:4000/home/origin',
      ),
      headers: <String, String>{
        'auth-token': token.toString(),
        'refresh-token': refreshToken.toString(),
      },
    );
    final showHome = ShowHome.fromJson(jsonDecode(res.body));
    String output = res.body;
    if (res.statusCode == 200) {
      homedd = HomeViewData(
        employeeID: showHome.user[0].employeeId,
        userName: showHome.user[0].userName,
        );
    } else {
      print(output);
    }
    return homedd;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Scaffold(
        body: ListView(
          //scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          children: [
            Center(
                child: FutureBuilder(
              future: getHomeData(),
              builder: (context, AsyncSnapshot<HomeViewData> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 500,
                    child: Center(
                      //alignment: Alignment.center,
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
                    ),
                  );
                } else
                  return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            itemCount: snapshot.data!.user.length,
                            itemBuilder: (context, i) {
                              return Column(
                                children: [
                                  Container(
                                    color: Colors.grey[900],
                                    child: ListTile(
                                      leading: Icon(Icons.person),
                                      title: Text(snapshot.data!.user[i].userName),
                                      trailing: Text(snapshot.data!.user[i].employeeId),
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
}
