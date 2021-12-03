// ignore_for_file: file_names, prefer_const_constructors, unused_local_variable, non_constant_identifier_names, prefer_const_literals_to_create_immutables, unused_import
// create group page
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class CreateGroup extends StatefulWidget {
  const CreateGroup({
    Key? key,
  }) : super(key: key);

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final storage = FlutterSecureStorage();

  Future createGroup() async {
    final token = await storage.read(key: "token");
    final refreshToken = await storage.read(key: "refreshToken");
    var res = await http.post(
        Uri.parse('https://chattycat-heroku.herokuapp.com/group/create'),
        headers: <String, String>{
          'auth-token': token.toString(),
          'refresh-token': refreshToken.toString(),
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'chatName': chatNameController.text
        });
    if (res.statusCode == 200) {
      print(res.body);
      showToast("Create new group successfully");
    } else {
      print(res.body.toString());
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message, gravity: ToastGravity.TOP, fontSize: 20);
  }

  //controller
  final chatNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            Text('Create new group',
                style: TextStyle(
                    fontWeight: FontWeight.w400, color: Colors.orange[400])),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.group_add,
              color: Colors.orange[400],
            ),
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
        child: Stack(
          children: [
            Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  createGroup();
                  Navigator.pop(context);
                },
                child: Icon(Icons.done),
              ),
              body: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
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
                    ),
                  ),
                  const SizedBox(height: 15),
                  editForm("Group Name", chatNameController),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // edit form
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
