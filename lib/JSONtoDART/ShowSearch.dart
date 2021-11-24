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
        required this.groups,
    });

    List<SearchName> searchName;
    List<String> groups;

    factory ShowSearch.fromJson(Map<String, dynamic> json) => ShowSearch(
        searchName: List<SearchName>.from(json["searchName"].map((x) => SearchName.fromJson(x))),
        groups: List<String>.from(json["groups"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "searchName": List<dynamic>.from(searchName.map((x) => x.toJson())),
        "groups": List<dynamic>.from(groups.map((x) => x)),
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
