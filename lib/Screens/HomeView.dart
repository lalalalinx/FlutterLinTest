// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, sized_box_for_whitespace, prefer_const_constructors, duplicate_ignore, void_checks
// Show Homepage
import 'dart:convert';

import 'package:chatki_project/JSONtoDART/ShowHome.dart';
import 'package:chatki_project/JSONtoDART/ShowSearch.dart';
import 'package:chatki_project/Screens/Others/GroupProfile.dart';
import 'package:chatki_project/Screens/Others/Otherprofile.dart';
import 'package:chatki_project/Screens/createGroup/CreateGroup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Search/Search.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
  }

  // this function get all username and group that current user are in the
  // return list of username and group
  Future<ShowHome> getHomeData() async {
    final token = await storage.read(key: "token");
    final refreshToken = await storage.read(key: "refreshToken");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = await http.get(
      Uri.parse(
        'https://chattycat-heroku.herokuapp.com/home/origin',
      ),
      headers: <String, String>{
        'auth-token': token.toString(),
        'refresh-token': refreshToken.toString(),
      },
    );
    final showHome = ShowHome.fromJson(jsonDecode(res.body));
    String output = res.body;
    if (res.statusCode == 200) {
      print(prefs.getString('employeeID'));
      print(prefs.getString('username'));
    } else {
      print(output);
    }
    return showHome;
  }

  Future search(String targetName) async {
    final tokenSearch = await storage.read(key: "token");
    final refreshTokenSearch = await storage.read(key: "refreshToken");
    var res = await http.post(
        Uri.parse(
          'https://chattycat-heroku.herokuapp.com/home/search',
        ),
        headers: <String, String>{
          'auth-token': tokenSearch.toString(),
          'refresh-token': refreshTokenSearch.toString(),
        },
        body: <String, String>{
          'targetName': targetName
        });
    final showSearch = showSearchFromJson(res.body);
    if (res.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Search(
              searchResult: showSearch,
              searchNameString: targetName,
            );
          },
        ),
      );
    }
  }

  final searchController = TextEditingController();
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
                future: getHomeData(),
                builder: (context, AsyncSnapshot<ShowHome> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return WaitingAction();
                  } else
                    return Padding(
                      padding: EdgeInsets.all(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          searchBar(),
                          addGroupButton(context),
                          personListView(snapshot),
                          SizedBox(height: 20),
                          groupListView(snapshot),
                        ],
                      ),
                    );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // show list of group
  Column groupListView(AsyncSnapshot<ShowHome> snapshot) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
          child: Center(
            child: Row(
              children: [
                Icon(Icons.group),
                Text(' Group'),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: snapshot.data!.sendGroup.length,
          itemBuilder: (context, i) {
            return Column(
              children: [
                Card(
                  color: Colors.white,
                  margin: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return GroupProfile(
                                  chatID: snapshot.data!.sendGroup[i].chatId,
                                  groupName:
                                      snapshot.data!.sendGroup[i].chatName,
                                );
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: ListTile(
                            title: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[600],
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(snapshot.data!.sendGroup[i].chatName,
                                    style: TextStyle(fontSize: 18)),
                              ],
                            ),
                            trailing: Text(
                              snapshot.data!.sendGroup[i].chatName,
                              style: TextStyle(color: Colors.grey[600]),
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
        ),
      ],
    );
  }

  Column personListView(AsyncSnapshot<ShowHome> snapshot) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
          child: Center(
            child: Row(
              children: [
                Icon(Icons.person),
                Text(' Person'),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: snapshot.data!.user.length,
          itemBuilder: (context, i) {
            return Column(
              children: [
                Card(
                  color: Colors.white,
                  margin: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return OtherProfile(
                                    targetID: snapshot.data!.user[i].employeeId,
                                    chatName: snapshot.data!.user[i].userName);
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: ListTile(
                            title: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[600],
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(snapshot.data!.user[i].userName,
                                    style: TextStyle(fontSize: 18)),
                              ],
                            ),
                            trailing: Text(
                              snapshot.data!.user[i].employeeId,
                              style: TextStyle(color: Colors.grey[600]),
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
        ),
      ],
    );
  }

  // Button add new group
  Container addGroupButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 210),
      width: 170,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CreateGroup();
              },
            ),
          );
        },
        child: Row(
          children: [
            Text(
              'Add new Group ',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            Icon(Icons.add_circle_outline_sharp),
          ],
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.orange[400],
          fixedSize: const Size(400, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }

  // search bar
  Padding searchBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 10, left: 15, right: 5),
      child: Row(
        children: [
          Container(
            width: 305,
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Search',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(0),
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              ),
              controller: searchController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Container(
              width: 60,
              child: ElevatedButton(
                onPressed: () {
                  search(searchController.text);
                },
                child: Icon(Icons.search),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[900],
                  fixedSize: const Size(350, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(30),
                      ),
                      side: BorderSide(color: Colors.black, width: 1.5)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // loading animation while wait action
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
