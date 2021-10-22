// ignore_for_file: file_names, prefer_const_constructors

import 'package:chatki_project/Profile/ProfileData.dart';
import 'package:chatki_project/Profile/ProfileUserData.dart';
import 'package:chatki_project/Screens/ProfileView.dart';
import 'package:flutter/material.dart';
import 'package:chatki_project/Profile/ProfildWidget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  List<String> quotes = ['11111111111', '22222', '33'];

  //controller
  final userFNameController = TextEditingController();
  final emailController = TextEditingController();
  final userLNameController = TextEditingController();
  final telController = TextEditingController();
  final zipController = TextEditingController();
  final cityController = TextEditingController();
  final streetController = TextEditingController();

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
                  return ProfileView();
                }));},
        child: Icon(Icons.done),
      ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              image: user.image,
              onClicked: () async {},
            ),
            const SizedBox(height: 20),
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
              'Employee ID: '+ user.employeeID,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  )
            ),),
            const SizedBox(height: 15),
            TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0))),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    ),
                    controller: userFNameController,
                  ),
                  const SizedBox(height: 15),
            TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Surname',
                      hintText: 'Surname',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0))),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    ),
                    controller: userLNameController,
                  ),
                  const SizedBox(height: 15),
            TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0))),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    ),
                    controller: userFNameController,
                  ),
            const SizedBox(height: 15),
            TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Tel',
                      hintText: 'Tel',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0))),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    ),
                    controller: telController,
                  ),
            const SizedBox(height: 15),
            TextFormField(
                    decoration: InputDecoration(
                      labelText: 'ZIP',
                      hintText: 'ZIP',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0))),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    ),
                    controller: zipController,
                  ),
                  const SizedBox(height: 15),
            TextFormField(
                    decoration: InputDecoration(
                      labelText: 'City',
                      hintText: 'City',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0))),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    ),
                    controller: cityController,
                  ),
                  const SizedBox(height: 15),
            TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Street',
                      hintText: 'Street',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0))),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    ),
                    controller: streetController,
                  ),
          ],
        ),
      );
}
