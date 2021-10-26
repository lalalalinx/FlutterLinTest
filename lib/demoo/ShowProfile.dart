// ignore_for_file: file_names

class showProfile {
  late String employeeID;
  late String email;
  late String tel;
  late String userFName;
  late String userLName;
  late String city;
  late String street;
  late String zip;

  showProfile(
      {required this.employeeID,
      required this.email,
      required this.tel,
      required this.userFName,
      required this.userLName,
      required this.city,
      required this.street,
      required this.zip});

  showProfile.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    tel = json['tel'];
    userFName = json['userFName'];
    userLName = json['userLName'];
    city = json['city'];
    street = json['street'];
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeID'] = this.employeeID;
    data['email'] = this.email;
    data['tel'] = this.tel;
    data['userFName'] = this.userFName;
    data['userLName'] = this.userLName;
    data['city'] = this.city;
    data['street'] = this.street;
    data['zip'] = this.zip;
    return data;
  }
}
