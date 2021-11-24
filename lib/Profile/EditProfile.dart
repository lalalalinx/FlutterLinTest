// ignore_for_file: file_names, prefer_const_constructors, unused_local_variable, non_constant_identifier_names

import 'package:chatki_project/Model/ProfileData.dart';
import 'package:chatki_project/Model/ProfileUserData.dart';
import 'package:chatki_project/Screens/ProfileView.dart';
import 'package:flutter/material.dart';
import 'package:chatki_project/Profile/ProfildWidget.dart';
import 'package:chatki_project/Model/EditProfileData.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.profileDatas}) : super(key: key);
  final ProfileData profileDatas;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final storage = FlutterSecureStorage();

  Future editProfile() async {
    final token = await storage.read(key: "token");
    final refreshToken = await storage.read(key: "refreshToken");
    var res = await http.post(Uri.parse('http://10.0.2.2:4000/profile/edit'),
        headers: <String, String>{
          'auth-token': token.toString(),
          'refresh-token': refreshToken.toString(),
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'userFName': userFNameController.text,
          'userLName': userLNameController.text,
          'email': emailController.text,
          'tel': telController.text,
          'zip': zipController.text,
          'city': cityController.text,
          'street': streetController.text
        });
    if (res.statusCode == 200) {
      print(res.body);
    } else {
      print(res.body.toString());
    }
  }

  //controller
  final userFNameController = TextEditingController();
  final userLNameController = TextEditingController();
  final emailController = TextEditingController();
  final telController = TextEditingController();
  final zipController = TextEditingController();
  final cityController = TextEditingController();
  final streetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = ProfileUserData.myUser;
    userFNameController.text = widget.profileDatas.userFName;
    userLNameController.text = widget.profileDatas.userLName;
    emailController.text = widget.profileDatas.email;
    telController.text = widget.profileDatas.tel;
    zipController.text = widget.profileDatas.zip;
    cityController.text = widget.profileDatas.city;
    streetController.text = widget.profileDatas.street;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //<---------------------------------------------ยืนยัน edit ตรงนี้
            editProfile();
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
            buildEdit(user),
          ],
        ),
      ),
    );
  }

  Widget buildEdit(user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text('Edit Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )),
            ),
            const SizedBox(height: 15),
            editForm("Name", userFNameController),
            const SizedBox(height: 15),
            editForm("Surname", userLNameController),
            const SizedBox(height: 15),
            editForm("Email", emailController),
            const SizedBox(height: 15),
            editForm("Tel", telController),
            const SizedBox(height: 15),
            editForm("City", cityController),
            const SizedBox(height: 15),
            editForm("Street", streetController),
            const SizedBox(height: 15),
            editForm("ZIP", zipController),
          ],
        ),
      );

  TextFormField editForm(String hText, TextEditingController controller) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: hText,
        hintText: hText,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
      ),
      controller: controller,
    );
  }
}
