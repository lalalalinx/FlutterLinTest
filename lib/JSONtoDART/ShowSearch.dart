// To parse this JSON data, do
//
//     final showSearch = showSearchFromJson(jsonString);

// ignore_for_file: file_names
// To parse this JSON data, do
//
//     final showSearch = showSearchFromJson(jsonString);

import 'dart:convert';

ShowSearch showSearchFromJson(String str) => ShowSearch.fromJson(json.decode(str));

String showSearchToJson(ShowSearch data) => json.encode(data.toJson());

class ShowSearch {
    ShowSearch({
        required this.searchName,
        required this.groups,
    });

    List<SearchName> searchName;
    List<Group> groups;

    factory ShowSearch.fromJson(Map<String, dynamic> json) => ShowSearch(
        searchName: List<SearchName>.from(json["searchName"].map((x) => SearchName.fromJson(x))),
        groups: List<Group>.from(json["groups"].map((x) => Group.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "searchName": List<dynamic>.from(searchName.map((x) => x.toJson())),
        "groups": List<dynamic>.from(groups.map((x) => x.toJson())),
    };
}

class Group {
    Group({
        required this.id,
        required this.chatID,
        required this.chatName,
        required this.isGroup,
    });

    String id;
    String chatID;
    String chatName;
    bool isGroup;

    factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["_id"],
        chatID: json["chatID"],
        chatName: json["chatName"],
        isGroup: json["isGroup"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "chatID": chatID,
        "chatName": chatName,
        "isGroup": isGroup,
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
