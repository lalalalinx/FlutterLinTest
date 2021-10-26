// ignore_for_file: file_names, prefer_const_constructors

//

import 'dart:convert';
import 'dart:js';

import 'package:chatki_project/Model/ProfileData.dart';
import 'package:chatki_project/Model/ProfileUserData.dart';
import 'package:chatki_project/demoo/ShowProfile.dart';
import 'package:flutter/material.dart';
import 'package:chatki_project/Profile/ProfildWidget.dart';
import 'package:chatki_project/Profile/EditProfile.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

  Future<void> getProfileData() async {
    //var url = "http://10.0.2.2:3000/profile/view";
    var response = await http.get(Uri.parse(
      'http://10.0.2.2:3000/profile/view',
    ));
    print(response.toString());
    var body = response.body;
    final showProfile = ShowProfile.fromJson(jsonDecode(body));
    print(showProfile.toString());
  }

