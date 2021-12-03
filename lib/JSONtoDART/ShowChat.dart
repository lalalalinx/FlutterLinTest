// To parse this JSON data, do
//
//     final showChat = showChatFromJson(jsonString);
// ignore_for_file: file_names

import 'package:meta/meta.dart';
import 'dart:convert';

ShowChat showChatFromJson(String str) => ShowChat.fromJson(json.decode(str));

String showChatToJson(ShowChat data) => json.encode(data.toJson());

class ShowChat {
    ShowChat({
        required this.getAllChat,
    });

    List<GetAllChat> getAllChat;

    factory ShowChat.fromJson(Map<String, dynamic> json) => ShowChat(
        getAllChat: List<GetAllChat>.from(json["getAllChat"].map((x) => GetAllChat.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "getAllChat": List<dynamic>.from(getAllChat.map((x) => x.toJson())),
    };
}

class GetAllChat {
    GetAllChat({
        required this.chatId,
        required this.chatName,
        required this.isGroup,
        required this.id,
        required this.employeeId,
        required this.previewChat,
    });

    String chatId;
    String chatName;
    bool isGroup;
    String id;
    String employeeId;
    List<PreviewChat> previewChat;

    factory GetAllChat.fromJson(Map<String, dynamic> json) => GetAllChat(
        chatId: json["chatID"],
        chatName: json["chatName"],
        isGroup: json["isGroup"],
        id: json["_id"],
        employeeId: json["employeeID"],
        previewChat: List<PreviewChat>.from(json["previewChat"].map((x) => PreviewChat.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "chatID": chatId,
        "chatName": chatName,
        "isGroup": isGroup,
        "_id": id,
        "employeeID": employeeId,
        "previewChat": List<dynamic>.from(previewChat.map((x) => x.toJson())),
    };
}

class PreviewChat {
    PreviewChat({
        required this.text,
        required this.time,
        required this.id,
    });

    String text;
    DateTime time;
    String id;

    factory PreviewChat.fromJson(Map<String, dynamic> json) => PreviewChat(
        text: json["text"],
        time: DateTime.parse(json["time"]),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "text": text,
        "time": time.toIso8601String(),
        "_id": id,
    };
}
