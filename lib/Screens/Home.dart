// ignore_for_file: file_names, prefer_const_constructors

import 'package:chatki_project/Login_Register/login.dart';
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

class _HomeState extends State<Home> {
  
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    readToken();
    super.initState();
    
  }

  Future<String?> readToken() async {
    final tokenStore = await storage.read(key: "token");
    print("Token in home:$tokenStore");
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


