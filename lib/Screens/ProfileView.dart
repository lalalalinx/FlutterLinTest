// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'Profile_build.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  List<String> quotes = ['11111111111', '22222', '33'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Scaffold(
        appBar: ProfileBuild(context),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [],
        ),
      ),
    );
  }
}
