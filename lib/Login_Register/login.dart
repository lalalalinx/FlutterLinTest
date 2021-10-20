import 'package:flutter/material.dart';
import 'register.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();

  Future save() async {
    var res = await http.post(Uri.parse('http://localhost:3000/login-register/login'),
    headers: <String,String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'email': emailController.text,
          'password': passwordController.text
        });
    print(res.body);     
  }

  //controller
  final emailController = TextEditingController();
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
                      labelText: 'Email Address',
                    ),
                    controller: emailController,
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
              print(emailController.text);
              print(passwordController.text);
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
