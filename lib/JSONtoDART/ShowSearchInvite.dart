// To parse this JSON data, do
//
//     final showSearchInvite = showSearchInviteFromJson(jsonString);

// ignore_for_file: file_names

import 'package:meta/meta.dart';
import 'dart:convert';

ShowSearchInvite showSearchInviteFromJson(String str) => ShowSearchInvite.fromJson(json.decode(str));

String showSearchInviteToJson(ShowSearchInvite data) => json.encode(data.toJson());

class ShowSearchInvite {
    ShowSearchInvite({
        required this.searchName,
    });

    List<SearchName> searchName;

    factory ShowSearchInvite.fromJson(Map<String, dynamic> json) => ShowSearchInvite(
        searchName: List<SearchName>.from(json["searchName"].map((x) => SearchName.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "searchName": List<dynamic>.from(searchName.map((x) => x.toJson())),
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
