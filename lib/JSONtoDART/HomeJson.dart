// To parse this JSON data, do
//
//     final showHome = showHomeFromJson(jsonString);

// ignore_for_file: file_names

import 'package:meta/meta.dart';
import 'dart:convert';

ShowHome showHomeFromJson(String str) => ShowHome.fromJson(json.decode(str));

String showHomeToJson(ShowHome data) => json.encode(data.toJson());

class ShowHome {
    ShowHome({
        required this.user,
        required this.sendGroup,
    });

    List<User> user;
    List<SendGroup> sendGroup;

    factory ShowHome.fromJson(Map<String, dynamic> json) => ShowHome(
        user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
        sendGroup: List<SendGroup>.from(json["sendGroup"].map((x) => SendGroup.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "user": List<dynamic>.from(user.map((x) => x.toJson())),
        "sendGroup": List<dynamic>.from(sendGroup.map((x) => x.toJson())),
    };
}

class SendGroup {
    SendGroup({
        required this.chatId,
        required this.chatName,
        required this.isGroup,
        required this.id,
    });

    String chatId;
    String chatName;
    bool isGroup;
    String id;

    factory SendGroup.fromJson(Map<String, dynamic> json) => SendGroup(
        chatId: json["chatID"],
        chatName: json["chatName"],
        isGroup: json["isGroup"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "chatID": chatId,
        "chatName": chatName,
        "isGroup": isGroup,
        "_id": id,
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
