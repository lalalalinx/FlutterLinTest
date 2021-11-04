// ignore_for_file: file_names, prefer_const_constructors, unused_local_variable, non_constant_identifier_names

import 'package:chatki_project/Model/ProfileData.dart';
import 'package:chatki_project/Model/ProfileUserData.dart';
import 'package:chatki_project/Screens/ProfileView.dart';
import 'package:flutter/material.dart';
import 'package:chatki_project/Profile/ProfildWidget.dart';
import 'package:chatki_project/Model/EditProfileData.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final storage = FlutterSecureStorage();
  late EditProfileData stored;

  @override
  // void initState() {
  //   storedData();
  //   super.initState();
  // }

  // void storedData() async {
  //   super.initState();
  //   stored = await getEditProfileData().whenComplete(() {
  //     setState(() {});
  //   });
  // }

  Future getEditProfileData() async {
    final token = await storage.read(key: "token");
    final refreshToken = await storage.read(key: "refreshToken");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = await http.post(
      Uri.parse('http://10.0.2.2:4000/profile/edit'),
      headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8'
      },
      body: <String, String>{
        'employeeID': employeeIDController.text,
        'email': emailController.text,
        'tel': telController.text,
        'userFName': userFNameController.text,
        'userLName': userLNameController.text,
        'zip': zipController.text,
        'city': cityController.text,
        'street': streetController.text,
      });
  }

  Future<String?> readToken() async {
    final tokenStore = await storage.read(key: "token");
    final refreshTokenStore = await storage.read(key: "refreshToken");
  }

  getEmployeeID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String? employeeID = prefs.getString('employeeID');
  return employeeID;
  }

  getEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String? email = prefs.getString('email');
  return email;
  }

  getTel() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String? tel = prefs.getString('tel');
  return tel;
  }

  getUserFName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String? userFName = prefs.getString('userFName');
  return userFName;
  }

  getUserLName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String? userLName = prefs.getString('userLName');
  return userLName;
  }

  getCity() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String? city = prefs.getString('city');
  return city;
  }

  getStreet() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String? street = prefs.getString('street');
  return street;
  }

  getzip() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String? zip = prefs.getString('zip');
  return zip;
  }

  
  // //controller
  final employeeIDController = TextEditingController();
  final emailController = TextEditingController();
  final telController = TextEditingController();
  final userFNameController = TextEditingController();
  final userLNameController = TextEditingController();
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
                //<---------------------------------------------ยืนยัน edit ตรงนี้
                Navigator.pop(context);
                },
        child: Icon(Icons.done),
      ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            // ProfileWidget(
            //   image: user.image,
            //   onClicked: () async {},
            // ),
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
            // Center(child: Text(
            //   'Employee ID: ',
            //   style: TextStyle(
            //       fontSize: 18,
            //       fontWeight: FontWeight.w500,
            //       color: Colors.black,
            //       )
            // ),),
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
