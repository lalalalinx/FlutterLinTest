// ignore_for_file: file_names, prefer_const_constructors, unused_local_variable, non_constant_identifier_names, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, deprecated_member_use, unnecessary_null_comparison, avoid_web_libraries_in_flutter
// edit profile page

import 'dart:io';

import 'package:chatki_project/Model/ProfileData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.profileDatas}) : super(key: key);
  final ProfileData profileDatas;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final storage = FlutterSecureStorage();
  final ImagePicker picker = ImagePicker();
  late PickedFile imageFile;

  //this function edit the personal information of the user
  Future editProfile() async {
    final token = await storage.read(key: "token");
    final refreshToken = await storage.read(key: "refreshToken");
    var res = await http.post(
        Uri.parse('https://chattycat-heroku.herokuapp.com/profile/edit'),
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
  File? image;

  @override
  Widget build(BuildContext context) {
    userFNameController.text = widget.profileDatas.userFName;
    userLNameController.text = widget.profileDatas.userLName;
    emailController.text = widget.profileDatas.email;
    telController.text = widget.profileDatas.tel;
    zipController.text = widget.profileDatas.zip;
    cityController.text = widget.profileDatas.city;
    streetController.text = widget.profileDatas.street;

    return Scaffold(
      appBar: AppBar(
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
              ),
            ),
          ],
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Edit Information',
                style: TextStyle(
                    fontWeight: FontWeight.w400, color: Colors.white)),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.edit),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              editProfile();
              Navigator.pop(context);
            },
            child: Icon(Icons.done),
          ),
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(height: 20),
              Container(child: imageProfile(), height: 150, width: 150),
              eFormInfo(),
            ],
          ),
        ),
      ),
    );
  }

  // edit form
  Container eFormInfo() => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
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
            const SizedBox(height: 30),
          ],
        ),
      );

  // edit form style
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

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            "Choose Profile photo",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                icon: Icon(Icons.photo_camera),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text('Camera'),
              ),
              FlatButton.icon(
                icon: Icon(Icons.photo_library_sharp),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text('Gallery'),
              ),
            ],
          )
        ],
      ),
    );
  }

  // take a photo part
  Future takePhoto(ImageSource source) async {
    try {
      final image = await picker.pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
      // pictureTest();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  // call a photo part
  Widget imageProfile() {
    return Center(
      child: Stack(
        children: <Widget>[
          image != null
              ? ClipOval(
                  child: Image.file(image!,
                      width: 150, height: 150, fit: BoxFit.cover))
              : CircleAvatar(
                  radius: 80,
                  backgroundImage:
                      AssetImage("assets/images/everyone's profile.jpg"),
                ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Colors.grey[900],
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet()),
                  );
                },
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
