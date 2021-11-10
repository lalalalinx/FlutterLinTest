// To parse this JSON data, do
//
//     final showSearch = showSearchFromJson(jsonString);

// ignore_for_file: file_names

import 'package:meta/meta.dart';
import 'dart:convert';

ShowSearch showSearchFromJson(String str) => ShowSearch.fromJson(json.decode(str));

String showSearchToJson(ShowSearch data) => json.encode(data.toJson());

class ShowSearch {
    ShowSearch({
        required this.searchName,
        required this.searchGroup,
    });

    List<SearchName> searchName;
    List<SearchGroup> searchGroup;

    factory ShowSearch.fromJson(Map<String, dynamic> json) => ShowSearch(
        searchName: List<SearchName>.from(json["searchName"].map((x) => SearchName.fromJson(x))),
        searchGroup: List<SearchGroup>.from(json["searchGroup"].map((x) => SearchGroup.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "searchName": List<dynamic>.from(searchName.map((x) => x.toJson())),
        "searchGroup": List<dynamic>.from(searchGroup.map((x) => x.toJson())),
    };
}

class SearchGroup {
    SearchGroup({
        required this.id,
        required this.chatName,
    });

    String id;
    String chatName;

    factory SearchGroup.fromJson(Map<String, dynamic> json) => SearchGroup(
        id: json["_id"],
        chatName: json["chatName"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "chatName": chatName,
    };
}

class SearchName {
    SearchName({
        required this.userName,
        required this.employeeId,
    });

    String userName;
    String employeeId;

    factory SearchName.fromJson(Map<String, dynamic> json) => SearchName(
        userName: json["userName"],
        employeeId: json["employeeID"],
    );

    Map<String, dynamic> toJson() => {
        "userName": userName,
        "employeeID": employeeId,
    };
}
