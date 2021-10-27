// ignore_for_file: file_names, prefer_const_constructors

// token - eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbXBsb3llZUlEIjoiRU0xMjMiLCJpYXQiOjE2MzUzMTg4OTQsImV4cCI6MTYzNTQwNTI5NH0.DMKYhq6HG8abTtRn1Yav4GIU5FUIfICXFP16QFi1gu4


import 'dart:convert';
import 'package:chatki_project/demoo/ShowProfile.dart';

import 'package:http/http.dart' as http;

  Future<void> getProfileData() async {
    var response = await http.get(Uri.parse(
      'http://10.0.2.2:3000/profile/view',
    ));
    print(response.toString());
    var body = response.body;
    final showProfile = ShowProfile.fromJson(jsonDecode(body));
  }

