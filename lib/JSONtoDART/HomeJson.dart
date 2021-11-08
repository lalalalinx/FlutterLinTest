// To parse this JSON data, do
//
//     final homeData = homeDataFromJson(jsonString);

// ignore_for_file: file_names

import 'package:meta/meta.dart';
import 'dart:convert';

ShowHome homeDataFromJson(String str) => ShowHome.fromJson(json.decode(str));

String homeDataToJson(ShowHome data) => json.encode(data.toJson());

class ShowHome {
    ShowHome({
        required this.user,
    });

    List<User> user;

    factory ShowHome.fromJson(Map<String, dynamic> json) => ShowHome(
        user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "user": List<dynamic>.from(user.map((x) => x.toJson())),
    };
}

class User {
    User({
        required this.userName,
        required this.employeeId,
    });

    String userName;
    String employeeId;

    factory User.fromJson(Map<String, dynamic> json) => User(
        userName: json["userName"],
        employeeId: json["employeeID"],
    );

    Map<String, dynamic> toJson() => {
        "userName": userName,
        "employeeID": employeeId,
    };
}
