// ignore_for_file: file_names, prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, dead_code

import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('S e a r c h'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 35, left: 10, right: 10, bottom: 10),
          child: ListView(
            children: [
              Row(children: [
                Icon(Icons.search),
                Text('Result of:'),
                SizedBox(width: 20,),
                Text('Jeremieeeeeee',style: TextStyle(fontSize: 20,color: Colors.blue),),
              ],),
              Divider(color: Colors.black,),
            ],
          ),
        ),
      );
  }
}