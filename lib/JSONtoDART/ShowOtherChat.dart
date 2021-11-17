// To parse this JSON data, do
//
//     final showOtherChat = showOtherChatFromJson(jsonString);

// ignore_for_file: file_names

import 'package:meta/meta.dart';
import 'dart:convert';

ShowOtherChat showOtherChatFromJson(String str) => ShowOtherChat.fromJson(json.decode(str));

String showOtherChatToJson(ShowOtherChat data) => json.encode(data.toJson());

class ShowOtherChat {
    ShowOtherChat({
        required this.chatId,
        required this.chatName,
        required this.isGroup,
        required this.id,
    });

    String chatId;
    String chatName;
    bool isGroup;
    String id;

    factory ShowOtherChat.fromJson(Map<String, dynamic> json) => ShowOtherChat(
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
