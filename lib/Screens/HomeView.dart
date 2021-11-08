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

  Future<ShowHome> getHomeData() async {
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
      print("yee");
    } else {
      print(output);
    }
    return showHome;
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
                builder: (context, AsyncSnapshot<ShowHome> snapshot) {
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
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, bottom: 10, left: 20, right: 20),
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: const InputDecoration(
                                    //labelText: 'Search',
                                    hintText: 'Search',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0))),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                  ),
                                  //controller: r,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      // <----------------------------
                                    },
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.black,
                                      fixedSize: const Size(350, 50),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: BorderSide(
                                              color: Colors.black, width: 1.5)),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.user.length,
                            itemBuilder: (context, i) {
                              return Column(
                                children: [
                                  Card(
                                    //padding: EdgeInsets.only(left: 10,right: 10),
                                    margin: EdgeInsets.all(10),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 10, bottom: 10),
                                      child: ListTile(
                                        title: Row(
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[600],
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                                snapshot.data!.user[i].userName,
                                                style: TextStyle(fontSize: 18)),
                                          ],
                                        ),
                                        trailing: Text(
                                          snapshot.data!.user[i].employeeId,
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                      ),
                                    ),
                                  ),
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
}
