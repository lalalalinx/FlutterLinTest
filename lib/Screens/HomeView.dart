// ignore_for_file: file_names, prefer_const_literals_to_create_immutables

import 'package:chatki_project/JSONtoDART/HomeJson.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class HomeView extends StatefulWidget {


  @override
  _HomeViewState createState() => _HomeViewState();
}
class _HomeViewState extends State<HomeView> {

    final storage = FlutterSecureStorage();
    @override
  void initState() {
    getHomeData();
    super.initState();
  }

    Future getHomeData() async {
    final token = await storage.read(key: "token");
    final refreshToken = await storage.read(key: "refreshToken");
    var res = await http.get(
      Uri.parse(
        'http://10.0.2.2:4000/home/origin',
      ),
      headers: <String, String>{
        'auth-token': token.toString(),
        'refresh-token': refreshToken.toString(),
      },
    );
    final homeData = homeDataFromJson(res.body);
    String output = res.body;
    if (res.statusCode == 200) {
      print(homeData.user[0].userName);
    } else {
      print(output);
    }
  }
  Future<String?> readToken() async {
    final tokenStore = await storage.read(key: "token");
    final refreshTokenStore = await storage.read(key: "refreshToken");
  }

  List<String> quotes = [
    '11111111111',
    '22222',
    '33' 
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, 
      ),
    );
  }
}
