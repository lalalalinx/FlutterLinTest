// ignore_for_file: file_names, prefer_const_constructors

import 'package:chatki_project/Login_Register/login.dart';
import 'package:chatki_project/Model/ProfileData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'ChatView.dart';
import 'HomeView.dart';
import 'ProfileView.dart';
import 'package:chatki_project/settings_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}


// final String employeeID;
//   //final String image;
//   final String email;
//   final String tel;
//   final String userFName;
//   final String userLName;
//   final String city; 
//   final String street;
//   final String zip;

class _HomeState extends State<Home> {
  List<ProfileData> profile = [
    ProfileData(
        userFName: "Lin",
        userLName: "Suk",
        email: "lin@gmail",
        tel: "08911",
        city: "god",
        street: "sake",
        zip: "1122",
        employeeID: "62070503406",
        ),
    ProfileData(
        userFName: "Jade",
        userLName: "Chan",
        email: "jade@gmail",
        tel: "1234",
        city: "river",
        street: "lake",
        zip: "12345",
        employeeID: "62070503409",
        ),
    ProfileData(
        userFName: "Doon",
        userLName: "Kit",
        email: "doon@gmail",
        tel: "08444",
        city: "road",
        street: "trip",
        zip: "56678",
        employeeID: "62070503422",
        ),
  ];
  
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    // readToken();
    super.initState();
    
  }

  // Future<String?> readToken() async {
  //   final tokenStore = await storage.read(key: "token");
  //   final refreshTokenStore = await storage.read(key: "refreshToken");
  //   print("Token in home:$tokenStore");
  //   print("Token in home:$refreshTokenStore");
  // }


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
                child: PopupMenuButton<int> (
                  padding: EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15),),),
                  color: Colors.grey[900],
                  onSelected: (item) => onSelected(context, item),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      padding: EdgeInsets.only(left: 15,right: 15),
                      value: 0,
                      child: Row(
                        children: [
                          Icon(Icons.settings,size: 20,),
                          const SizedBox(width: 8,),
                          Text('Settings', style: TextStyle(fontSize: 14),),
                        ],
                      ),
                    ),
                    PopupMenuDivider(),
                    PopupMenuItem(
                      padding: EdgeInsets.only(left: 15,right: 15),
                      value: 1,
                      child: Row(
                        children: [
                          Icon(Icons.logout,size: 20,),
                          const SizedBox(width: 8,),
                          Text('Sign Out', style: TextStyle(fontSize: 14),),
                        ],
                      ),
                    ),
                  ],
                    ),
              ),
            ],
            //leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.red],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              )
            ),
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

      void onSelected(BuildContext context, int item){
        switch (item) {
          case 0:
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          break;
          case 1:
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Login()),
              (route) => false,
            );
          break;
        }
      }
}


