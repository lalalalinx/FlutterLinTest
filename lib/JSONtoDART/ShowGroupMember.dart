// To parse this JSON data, do
//
//     final showGroupMember = showGroupMemberFromJson(jsonString);

// ignore_for_file: file_names

import 'package:meta/meta.dart';
import 'dart:convert';

List<ShowGroupMember> showGroupMemberFromJson(String str) => List<ShowGroupMember>.from(json.decode(str).map((x) => ShowGroupMember.fromJson(x)));

String showGroupMemberToJson(List<ShowGroupMember> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShowGroupMember {
    ShowGroupMember({
        required this.id,
        required this.userName,
        required this.employeeId,
    });

    String id;
    String userName;
    String employeeId;

    factory ShowGroupMember.fromJson(Map<String, dynamic> json) => ShowGroupMember(
        id: json["_id"],
        userName: json["userName"],
        employeeId: json["employeeID"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userName": userName,
        "employeeID": employeeId,
    };
}
