// ignore_for_file: prefer_const_constructors

import 'package:chatki_project/Screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();
  final storage = FlutterSecureStorage();

  Future login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = await http.post(
        Uri.parse('http://10.0.2.2:4000/login-register/login'),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'userName': userNameController.text,
          'password': passwordController.text
        });
    if (res.statusCode == 200) {
      Map<String, dynamic> output = jsonDecode(res.body);
      storage.write(key: "token", value: output['token']);
      storage.write(key: "refreshToken", value: output['refreshToken']);
      Map<String, dynamic> decodedToken = JwtDecoder.decode(output['token']);
      prefs.setString('employeeID', decodedToken['employeeID']);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Home();
      }));
    } else {
      Map<String,dynamic> err = jsonDecode(res.body);
      print(err["Error"]);
      showToast("Error: ${err["Error"]}");
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.TOP,
      fontSize: 20
    );
  }

  //controller
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(25, 55, 25, 0),
      child: Column(
        children: [
          Form(
              key: formkey,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome to อรุ่มเจ๊าะ",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      hintText: 'Username',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    ),
                    controller: userNameController,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    ),
                    controller: passwordController,
                    obscureText: true,
                  ),
                ],
              )),
          SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
            child: ElevatedButton(
              onPressed: () {
                userNameController.text = 'jeremiee';
                passwordController.text = '1234';
                login();
              },
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                fixedSize: const Size(350, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.black, width: 1.5)),
              ),
            ),
          ),
          Text("- OR -", style: TextStyle(color: Colors.black)),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
            child: ElevatedButton(
              child: const Text(
                'Register',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                fixedSize: const Size(350, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.black, width: 1.5)),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Register();
                }));
              },
            ),
          ),
          Container(
            child: Image.asset("assets/images/arumjoh.png",
                height: 200, width: 200),
          ),
        ],
      ),
    ));
  }
}
