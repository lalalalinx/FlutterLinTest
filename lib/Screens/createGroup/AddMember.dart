// ignore_for_file: file_names, prefer_const_constructors, unused_local_variable, non_constant_identifier_names, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'dart:convert';

import 'package:chatki_project/JSONtoDART/ShowSearchInvite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class AddMember extends StatefulWidget {
  const AddMember({
    Key? key,required this.chatID
  }) : super(key: key);
  final String chatID;

  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  final storage = FlutterSecureStorage();
  //controller
  final searchController = TextEditingController();

  List<SearchName> searchData = [];

  Future searchInvite(String targetName) async {
    final tokenSearch = await storage.read(key: "token");
    final refreshTokenSearch = await storage.read(key: "refreshToken");
    var res = await http.post(
        Uri.parse(
          'https://chattycat-heroku.herokuapp.com/group/invite/search',
        ),
        headers: <String, String>{
          'auth-token': tokenSearch.toString(),
          'refresh-token': refreshTokenSearch.toString(),
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'targetName': targetName
        });
    final showSearchInvite = showSearchInviteFromJson(res.body);
    setState(() {
      searchData.clear();
    });
    if (res.statusCode == 200) {
      print("OK");
      for (var member in showSearchInvite.searchName) {
        setState(() {
          searchData.add(member);
        });
      }
    }
  }

  Future invite(String targetID) async {
    final tokenSearch = await storage.read(key: "token");
    final refreshTokenSearch = await storage.read(key: "refreshToken");
    var res = await http.post(
        Uri.parse(
          'https://chattycat-heroku.herokuapp.com/group/invite',
        ),
        headers: <String, String>{
          'auth-token': tokenSearch.toString(),
          'refresh-token': refreshTokenSearch.toString(),
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'targetID': targetID,
          'chatID': widget.chatID
        });
    
    // setState(() {
    //   searchData.clear();
    // });
    if (res.statusCode == 200) {
      var output = jsonDecode(res.body);
      showToast(output['messages']);
    }
  }

    void showToast(String message) {
    Fluttertoast.showToast(
        msg: message, gravity: ToastGravity.TOP, fontSize: 20);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AddMemberAppBar(context),
      body: Container(
        color: Colors.grey[100],
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  searchBar(),
                  SizedBox(height: 20),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: searchData.length,
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          Card(
                              color: Colors.white,
                              margin: EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  //padding: EdgeInsets.only(left: 10,right: 10),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Confirm?"),
                                              content:
                                                  Text("Add this employee?"),
                                              actions: [
                                                FlatButton(
                                                    onPressed: () {Navigator.pop(context);},
                                                    child: Text('No',style: TextStyle(color: Colors.deepPurple),)),
                                                FlatButton(
                                                    onPressed: () {
                                                      invite(searchData[i].employeeId);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Yes',style: TextStyle(color: Colors.deepPurple))),
                                              ],
                                            );
                                          });
                                      // Navigator.push(context,
                                      //     MaterialPageRoute(builder: (context) {
                                      //   return OtherProfile(
                                      //       targetID: snapshot.data!.user[i].employeeId,
                                      //       chatName: snapshot.data!.user[i].userName);
                                      // }));
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 5, bottom: 5),
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
                                            Text(searchData[i].userName,
                                                style: TextStyle(fontSize: 18)),
                                          ],
                                        ),
                                        trailing: Text(
                                          searchData[i].employeeId,
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          //Divider(thickness: 1),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar AddMemberAppBar(BuildContext context) {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[900],
        leading: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.white,
                )),
          ],
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Add new member',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                )),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.group_add),
            SizedBox(
              width: 10,
            ),
          ],
        ));
  }

  Row searchBar() {
    return Row(
      children: [
        Container(
          width: 272,
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
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            ),
            controller: searchController,
          ),
        ),
        Container(
          width: 60,
          child: ElevatedButton(
            onPressed: () {
              searchInvite(searchController.text);
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
      ],
    );
  }
}
