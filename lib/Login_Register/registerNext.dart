// ignore_for_file: prefer_const_constructors, avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterNext extends StatefulWidget {
  const RegisterNext({Key? key}) : super(key: key);

  @override
  _RegisterNextState createState() => _RegisterNextState();
}

class _RegisterNextState extends State<RegisterNext> {
  final formkey = GlobalKey<FormState>();

  Future save() async {
    var res = await http.post(
        Uri.parse('http://10.0.2.2:3000/login-register/register'),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'image': imageController.text,
          'userFName': userFNameController.text,
          'userLName': userLNameController.text,
          'tel': telController.text,
          'zip': zipController.text,
          'city': cityController.text,
          'street': streetController.text,
        });
    print(res.body);
  }

  //var

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
          padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 40),
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
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'image',
                      hintText: 'image',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    ),
                    controller: imageController,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    ),
                    controller: userFNameController,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Surname',
                      hintText: 'Surname',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    ),
                    controller: userLNameController,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Tel',
                      hintText: 'Tel',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    ),
                    controller: telController,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: 
                    TextFormField(
                    decoration: InputDecoration(
                      labelText: 'ZIP',
                      hintText: 'ZIP',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    ),
                    controller: zipController,
                  ),
                    ),
                    SizedBox(
                    width: 10.0,
                    ),
                    Expanded(child:
                    TextFormField(
                    decoration: InputDecoration(
                      labelText: 'City',
                      hintText: 'City',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    ),
                    controller: cityController,
                  ),
                    ),
                    SizedBox(
                    width: 10.0,
                    ),
                    Expanded(child: 
                    TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Street',
                      hintText: 'Street',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    ),
                    controller: streetController,
                  ),
                    ),
                  ],
                  ),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     labelText: 'zip',
                  //     hintText: 'zip',
                  //     border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.all(Radius.circular(6.0))),
                  //     contentPadding:
                  //         EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  //   ),
                  //   controller: zipController,
                  // ),
                  // SizedBox(
                  //   height: 20.0,
                  // ),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     labelText: 'city',
                  //     hintText: 'city',
                  //     border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.all(Radius.circular(6.0))),
                  //     contentPadding:
                  //         EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  //   ),
                  //   controller: cityController,
                  // ),
                  // SizedBox(
                  //   height: 20.0,
                  // ),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     labelText: 'street',
                  //     hintText: 'street',
                  //     border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.all(Radius.circular(6.0))),
                  //     contentPadding:
                  //         EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  //   ),
                  //   controller: streetController,
                  // ),
                  // TextButton(
                  //   style: TextButton.styleFrom(
                  //     backgroundColor: Colors.deepPurple[700],
                  //     primary: Colors.white,
                  //     padding:
                  //         EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  //     shape: shape,
                  //   ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // save();
                        print(imageController.text);
                        print(userFNameController.text);
                        print(userLNameController.text);
                        print(telController.text);
                        print(zipController.text);
                        print(cityController.text);
                        print(streetController.text);
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
}
