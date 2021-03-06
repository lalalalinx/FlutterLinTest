import 'package:chatki_project/Screens/chat/IndividualChat.dart';
import 'package:chatki_project/Screens/createGroup/CreateGroup.dart';
import 'package:flutter/material.dart';
import 'Screens/Home.dart';
import 'Login_Register/login.dart';
import 'Login_Register/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: Login(),
    );
  }
}
