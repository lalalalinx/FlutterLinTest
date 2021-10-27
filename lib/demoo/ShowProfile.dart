// To parse this JSON data, do
//
//     final showProfile = showProfileFromJson(jsonString);

import 'dart:convert';

ShowProfile showProfileFromJson(String str) => ShowProfile.fromJson(json.decode(str));

String showProfileToJson(ShowProfile data) => json.encode(data.toJson());

class ShowProfile {
    ShowProfile({
        required this.view,
    });

    List<String> view;

    factory ShowProfile.fromJson(Map<String, dynamic> json) => ShowProfile(
        view: List<String>.from(json["view"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "view": List<dynamic>.from(view.map((x) => x)),
    };
}