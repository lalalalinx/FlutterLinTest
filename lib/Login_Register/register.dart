// ignore_for_file: prefer_const_constructors
// register new user page
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'registerNext.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}
class _RegisterState extends State<Register> {
  final formkey = GlobalKey<FormState>();
  final storage = FlutterSecureStorage();

  //Register function sent register information via API and sent respond back
  Future registerUser() async {
    var res = await http.post(
        Uri.parse('https://chattycat-heroku.herokuapp.com/login-register/register'),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'userName': userNameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'employeeID': employeeidController.text
        });
    if (res.statusCode == 200) {
      print(res.body);
      login();
      showToast("Registered successfully");
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return RegisterNext();
      }));
    } else {
      Map<String, dynamic> err = jsonDecode(res.body);
      print(err["message"]);
      showToast("Error: ${err["message"]}");
    }
  }

  //use function login to prevent when user register half way done and exit the program
  Future login() async {
    var res = await http.post(
        Uri.parse('https://chattycat-heroku.herokuapp.com/login-register/login'),
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
    } else {
      Map<String, dynamic> err = jsonDecode(res.body);
      print(err["Error"]);
      showToast("Error: ${err["Error"]}");
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message, gravity: ToastGravity.TOP, fontSize: 20);
  }

  //controller
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final employeeidController = TextEditingController();
  @override
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
                    "Register",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Create an Account",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  registerForm('Username', userNameController),
                  SizedBox(
                    height: 20.0,
                  ),
                  registerForm('Email', emailController),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
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
                  SizedBox(
                    height: 20.0,
                  ),
                  registerForm('EmployeeID', employeeidController),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: ElevatedButton(
                      onPressed: () {
                        registerUser();
                      },
                      child: const Text(
                        'Next',
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
        ),);
  }

  // register form style
  TextFormField registerForm(String hText, TextEditingController controller) {
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
