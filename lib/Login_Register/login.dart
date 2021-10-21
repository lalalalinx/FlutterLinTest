import 'dart:convert';

import 'package:chatki_project/Screens/Home.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();

  Future login() async {
    var res = await http.post(Uri.parse('http://10.0.2.2:3000/login-register/login'),
    headers: <String,String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'userName': userNameController.text,
          'password': passwordController.text
        });
    String output = res.body;
    if(res.statusCode == 200)
    {
      print(output);
      await storage.write(key: "token", value: output);
      String? tokenstart = await storage.read(key: "token");
      print(tokenstart);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return Home();}));
    }
    else
    {
      print(output);
    }  
  }

  //controller
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(25, 100, 25, 0),
      child: Column(
        children: [
          Image.asset("assets/images/arumjoh.png"),
          Form(
              key: formkey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                    controller: userNameController,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    controller: passwordController,
                  ),
                ],
              )),
          TextButton(
            child: const Text("Login"),
            onPressed: () {
              print(userNameController.text);
              print(passwordController.text);
              login();
            },
          ),
          TextButton(
            child: const Text("Register"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Register();
              }));
            },
          )
        ],
      ),
    ));
  }
}
