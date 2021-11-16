// ignore_for_file: file_names, prefer_const_constructors, unused_local_variable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CreateGroup extends StatefulWidget {
  const CreateGroup({
    Key? key,
  }) : super(key: key);
  //final ProfileData profileDatas;

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final storage = FlutterSecureStorage();

  // Future editProfile() async {
  //   final token = await storage.read(key: "token");
  //   final refreshToken = await storage.read(key: "refreshToken");
  //   var res = await http.post(Uri.parse('http://10.0.2.2:4000/profile/edit'),
  //       headers: <String, String>{
  //         'auth-token': token.toString(),
  //         'refresh-token': refreshToken.toString(),
  //         'Context-Type': 'application/json;charSet=UTF-8'
  //       },
  //       body: <String, String>{
  //         'userFName': userFNameController.text,
  //         'userLName': userLNameController.text,
  //         'email': emailController.text,
  //         'tel': telController.text,
  //         'zip': zipController.text,
  //         'city': cityController.text,
  //         'street': streetController.text
  //       });
  //   if (res.statusCode == 200) {
  //     print(res.body);
  //   } else {
  //     print(res.body.toString());
  //   }
  // }

  // //controller
  // final userFNameController = TextEditingController();
  // final userLNameController = TextEditingController();
  // final emailController = TextEditingController();
  // final telController = TextEditingController();
  // final zipController = TextEditingController();
  // final cityController = TextEditingController();
  // final streetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final user = ProfileUserData.myUser;
    // userFNameController.text = widget.profileDatas.userFName;
    // userLNameController.text = widget.profileDatas.userLName;
    // emailController.text = widget.profileDatas.email;
    // telController.text = widget.profileDatas.tel;
    // zipController.text = widget.profileDatas.zip;
    // cityController.text = widget.profileDatas.city;
    // streetController.text = widget.profileDatas.street;

    return Scaffold(
      backgroundColor: Colors.grey[900],
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
                  )),
            ],
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Create new group',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  )),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.group_add),
              SizedBox(
                width: 10,
              ),
            ],
          )),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  //<---------------------------------------------ยืนยัน create ตรงนี้
                  //editProfile();
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
                  //buildEdit(user),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Center(
                    child: Row(
                      children: [
                        Text('Edit Group Profile ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )),
                        Icon(Icons.edit),
                      ],
                    )
                  ),
                  
                  const SizedBox(height: 15),
                  editForm("Group Name"),
                  SizedBox(height: 30),
                  Center(
                    child: Row(
                      children: [
                        Text('Member  ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )),
                        Icon(Icons.group),
                      ],
                    )
                  ),
                  const SizedBox(height: 15),
                  editForm("EmployeeID"),
                ],
              ),
            ),
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
            editForm("Group Name"),

            // const SizedBox(height: 15),
            // editForm("Name", userFNameController),
            // const SizedBox(height: 15),
            // editForm("Surname", userLNameController),
            // const SizedBox(height: 15),
            // editForm("Email", emailController),
            // const SizedBox(height: 15),
            // editForm("Tel", telController),
            // const SizedBox(height: 15),
            // editForm("City", cityController),
            // const SizedBox(height: 15),
            // editForm("Street", streetController),
            // const SizedBox(height: 15),
            // editForm("ZIP", zipController),
          ],
        ),
      );

  // TextFormField editForm(String hText, TextEditingController controller) {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //       labelText: hText,
  //       hintText: hText,
  //       border: OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(30.0))),
  //       contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
  //     ),
  //     controller: controller,
  //   );
  // }
  TextFormField editForm(String hText) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: hText,
        hintText: hText,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
      ),
    );
  }
}
