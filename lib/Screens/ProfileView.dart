// ignore_for_file: file_names, prefer_const_constructors

import 'package:chatki_project/Model/ProfileData.dart';
import 'package:chatki_project/Model/ProfileUserData.dart';
import 'package:flutter/material.dart';
import 'package:chatki_project/Profile/ProfildWidget.dart';
import 'package:chatki_project/Profile/EditProfile.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  List<String> quotes = ['11111111111', '22222', '33'];

  @override
  Widget build(BuildContext context) {
    final user = ProfileUserData.myUser;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
        onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return EditProfile();
                }));},
        child: Icon(Icons.edit),
      ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              image: user.image,
              onClicked: () async {},
            ),
            const SizedBox(height: 24),
            buildName(user),
          ],
        ),
      ),
    );
  }

  Widget buildName(user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text(
              'Employee ID ',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[900],
                  )
            ),),
            Center(
              child: Text(
                user.employeeID,
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
              user.userFName+'  '+ user.userLName,
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
              user.email,
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
              user.tel,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              'ZIP - City - Street',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 5),
            Text(
              user.zip + ' - ' + user.city + ' - ' + user.street,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      );
}
