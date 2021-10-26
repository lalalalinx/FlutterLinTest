// ignore_for_file: file_names, prefer_const_constructors

import 'package:chatki_project/Model/chatData.dart';
import 'package:chatki_project/Screens/HomeView.dart';
import 'package:chatki_project/Screens/ProfileView.dart';
import 'package:chatki_project/demoo/ChatViewDemo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeDemo extends StatefulWidget {
  const HomeDemo({Key? key,required this.chatdata,required this.sourceChat}) : super(key: key);
  final List<ChatData> chatdata;
  final ChatData sourceChat;


  @override
  _HomeDemoState createState() => _HomeDemoState();
}

class _HomeDemoState extends State<HomeDemo> {
  
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    readToken();
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
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
            ],
            leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
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
              ChatViewDemo(
                chatdata:widget.chatdata,
                sourceChat: widget.sourceChat,
              ),
              ProfileView(),
            ],
          ),
        ),
      );
}
