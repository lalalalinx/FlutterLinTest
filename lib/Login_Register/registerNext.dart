// ignore_for_file: prefer_const_constructors, avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'login.dart';

class RegisterNext extends StatefulWidget {
  const RegisterNext({Key? key}) : super(key: key);

  @override
  _RegisterNextState createState() => _RegisterNextState();
}

class _RegisterNextState extends State<RegisterNext> {
  final formkey = GlobalKey<FormState>();
  final storage = FlutterSecureStorage();

  Future savePersonalInfo() async {
    final token = await storage.read(key: "token");
    final refreshToken = await storage.read(key: "refreshToken");
    var res = await http.post(Uri.parse('http://10.0.2.2:4000/profile/edit'),
        headers: <String, String>{
          'auth-token': token.toString(),
          'refresh-token': refreshToken.toString(),
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          // 'image': imageController.text,
          'userFName': userFNameController.text,
          'userLName': userLNameController.text,
          'tel': telController.text,
          'zip': zipController.text,
          'city': cityController.text,
          'street': streetController.text,
        });
    if (res.statusCode == 200) {
      print(res.body);
      showToast("Added information successfully");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Login();
      }));
    } else {
      print(res.body.toString());
    }
  }

    void showToast(String message) {
    Fluttertoast.showToast(
        msg: message, gravity: ToastGravity.TOP, fontSize: 20);
  }

  //controller
  final imageController = TextEditingController();
  final userFNameController = TextEditingController();
  final userLNameController = TextEditingController();
  final telController = TextEditingController();
  final zipController = TextEditingController();
  final cityController = TextEditingController();
  final streetController = TextEditingController();
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(60),
    );
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 25,
                color: Colors.black,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Profile Information",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Add Profile",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  registerInfoForm('Image', imageController),
                  SizedBox(
                    height: 20.0,
                  ),
                  registerInfoForm('Name', userFNameController),
                  SizedBox(
                    height: 20.0,
                  ),
                  registerInfoForm('Surname', userLNameController),
                  SizedBox(
                    height: 20.0,
                  ),
                  registerInfoForm('Tel', telController),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      registerCForm('ZIP', zipController),
                      SizedBox(
                        width: 10.0,
                      ),
                      registerCForm('City', cityController),
                      SizedBox(
                        width: 10.0,
                      ),
                      registerCForm('Street', streetController),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: ElevatedButton(
                      onPressed: () {
                        savePersonalInfo(); 
                      },
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        fixedSize: const Size(200, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Expanded registerCForm(String hText, TextEditingController controller) {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: hText,
          hintText: hText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0))),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        ),
        controller: controller,
      ),
    );
  }

  TextFormField registerInfoForm(
      String hText, TextEditingController controller) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: hText,
        hintText: hText,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0))),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      ),
      controller: controller,
    );
  }
}
