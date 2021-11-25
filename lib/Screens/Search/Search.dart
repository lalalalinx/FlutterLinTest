// ignore_for_file: file_names, prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, dead_code

import 'package:chatki_project/JSONtoDART/ShowSearch.dart';
import 'package:chatki_project/Screens/Home.dart';
import 'package:chatki_project/Screens/Others/Otherprofile.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search(
      {Key? key, required this.searchResult, required this.searchNameString})
      : super(key: key);
  final ShowSearch searchResult;
  final String searchNameString;

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return Home();
              }));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: Colors.white,
            )),
        title: Text('S e a r c h'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.grey[300],
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.search),
                              Text(' Result of :'),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                '\" ' + widget.searchNameString + ' \"',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 20, right: 20, bottom: 10),
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

                // ListView for employee
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: widget.searchResult.searchName.length,
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
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return OtherProfile(
                                        targetID: widget.searchResult
                                            .searchName[i].employeeId,
                                        chatName: widget.searchResult
                                            .searchName[i].userName);
                                  }));
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
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                            widget.searchResult.searchName[i]
                                                .userName,
                                            style: TextStyle(fontSize: 18)),
                                      ],
                                    ),
                                    trailing: Text(
                                      widget.searchResult.searchName[i]
                                          .employeeId,
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Divider(thickness: 1),
                      ],
                    );
                  },
                ),
                // group
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 20, right: 20, bottom: 10),
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
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: widget.searchResult.groups.length,
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
                                  // Navigator.push(context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) {
                                  //   return OtherProfile(
                                  //       targetID: widget.searchResult
                                  //           .searchGroup[i].chatName);
                                  // }));
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
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                            widget.searchResult.groups[i],
                                            style: TextStyle(fontSize: 18)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
    );
  }
}
