import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formkey = GlobalKey<FormState>();

  Future save() async {
    var res = await http.post(
        Uri.parse('http://10.0.2.2:3000/login-register/register'),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'userName': usernameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'employeeID': employeeidController.text
        });
    print(res.body);
  }

  //var

  //controller
  final usernameController = TextEditingController();
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
        appBar: AppBar(
          title: const Text("Register"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(40),
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: 'Username',
                    ),
                    
                    controller: usernameController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      hintText: 'Email Address',
                    ),
                    controller: emailController,
                    
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Password',
                    ),
                    controller: passwordController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Confirm Password',
                    ),
                    controller: confirmPasswordController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'EmployeeID',
                      hintText: 'EmployeeID',
                    ),
                    controller: employeeidController,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.deepPurple[700],
                      primary: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      shape: shape,
                    ),
                    child: Text("Confirm"),
                    onPressed: () {
                      // save();
                      print(usernameController.text);
                      print(emailController.text);
                      print(passwordController.text);
                      print(confirmPasswordController.text);
                      print(employeeidController.text);
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
