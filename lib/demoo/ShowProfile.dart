// To parse this JSON data, do
//
//     final showProfile = showProfileFromJson(jsonString);

import 'dart:convert';

ShowProfile showProfileFromJson(String str) => ShowProfile.fromJson(json.decode(str));

String showProfileToJson(ShowProfile data) => json.encode(data.toJson());

class ShowProfile {
    ShowProfile({
        required this.employeeId,
        required this.email,
        required this.tel,
        required this.userFName,
        required this.userLName,
        required this.city,
        required this.street,
        required this.zip,
    });

    String employeeId;
    String email;
    String tel;
    String userFName;
    String userLName;
    String city;
    String street;
    String zip;

    factory ShowProfile.fromJson(Map<String, dynamic> json) => ShowProfile(
        employeeId: json["employeeID"],
        email: json["email"],
        tel: json["tel"],
        userFName: json["userFName"],
        userLName: json["userLName"],
        city: json["city"],
        street: json["street"],
        zip: json["zip"],
    );

    Map<String, dynamic> toJson() => {
        "employeeID": employeeId,
        "email": email,
        "tel": tel,
        "userFName": userFName,
        "userLName": userLName,
        "city": city,
        "street": street,
        "zip": zip,
    };
}
