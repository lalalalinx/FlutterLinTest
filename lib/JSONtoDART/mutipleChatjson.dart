// To parse this JSON data, do
//
//     final multipleChatList = multipleChatListFromJson(jsonString);

// ignore_for_file: file_names

import 'package:meta/meta.dart';
import 'dart:convert';

MultipleChatList multipleChatListFromJson(String str) => MultipleChatList.fromJson(json.decode(str));

String multipleChatListToJson(MultipleChatList data) => json.encode(data.toJson());

class MultipleChatList {
    MultipleChatList({
        required this.getAllChat,
    });

    List<GetAllChat> getAllChat;

    factory MultipleChatList.fromJson(Map<String, dynamic> json) => MultipleChatList(
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
        required this.id,
        required this.previewChat,
    });

    String chatId;
    String chatName;
    String id;
    List<PreviewChat> previewChat;

    factory GetAllChat.fromJson(Map<String, dynamic> json) => GetAllChat(
        chatId: json["chatID"],
        chatName: json["chatName"],
        id: json["_id"],
        previewChat: List<PreviewChat>.from(json["previewChat"].map((x) => PreviewChat.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "chatID": chatId,
        "chatName": chatName,
        "_id": id,
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
