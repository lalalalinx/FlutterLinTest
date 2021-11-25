// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chatki_project/Login_Register/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'ChatView.dart';
import 'HomeView.dart';
import 'ProfileView.dart';
import 'package:chatki_project/settings_page.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final storage = FlutterSecureStorage();

  void logout() async {
    final token = await storage.read(key: "token");
    final refreshToken = await storage.read(key: "refreshToken");
    var res = await http.delete(
      Uri.parse(
        'https://chattycat-heroku.herokuapp.com/login-register/logout',
      ),
      headers: <String, String>{
        'auth-token': token.toString(),
        'refresh-token': refreshToken.toString(),
      },
    );
    if (res.statusCode == 204) {
      showToast("Successfully logout");
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message, gravity: ToastGravity.TOP, fontSize: 20);
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: TabBar(
            tabs: const [
              Tab(text: 'Home', icon: Icon(Icons.home)),
              Tab(text: 'Chat', icon: Icon(Icons.chat)),
              Tab(text: 'Profile', icon: Icon(Icons.person)),
            ],
            labelStyle: TextStyle(color: Color(0xFFF00), fontSize: 12),
          ),
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            backgroundColor: Colors.grey[900],
            elevation: 5,
            title: Text(
              "Arumjoh",
              style: TextStyle(
                letterSpacing: 4,
              ),
            ),
            centerTitle: true,
            actions: [
              Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.white,
                  iconTheme: IconThemeData(color: Colors.white),
                  textTheme: TextTheme().apply(bodyColor: Colors.white),
                ),
                child: configButton(context),
              ),
            ],
            //leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.red],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              )),
            ),
          ),
          body: TabBarView(
            children: [
              HomeView(),
              ChatView(),
              ProfileView(),
            ],
          ),
        ),
      );

  PopupMenuButton<int> configButton(BuildContext context) {
    return PopupMenuButton<int>(
      padding: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      color: Colors.grey[900],
      onSelected: (item) => onSelected(context, item),
      itemBuilder: (context) => [
        PopupMenuItem(
          padding: EdgeInsets.only(left: 15, right: 15),
          value: 0,
          child: Row(
            children: [
              Icon(
                Icons.settings,
                size: 20,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                'Settings',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          padding: EdgeInsets.only(left: 15, right: 15),
          value: 1,
          child: Row(
            children: [
              Icon(
                Icons.logout,
                size: 20,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                'Sign Out',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Settings()),
        );
        break;
      case 1:
        logout();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()),
          (route) => false,
        );
        break;
    }
  }
}
