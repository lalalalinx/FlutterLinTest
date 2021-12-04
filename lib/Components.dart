// ignore_for_file: file_names, sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names
// component usage for other files

import 'package:flutter/material.dart';

class Components {

  // waiting action animation while loading data
  static Container waitingAction() {
    return Container(
      height: 500,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200.0,
            ),
            CircularProgressIndicator(),
            SizedBox(
              height: 30.0,
            ),
            Text(
              'L o a d i n g . . .',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  // show small profile, 
  // asset - directory of picture
  static Container OvalProfile(String asset) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(asset),
        ),
      ),
    );
  }

  // vvvv components for ProfileView.dart and OtherProfileView.dart vvvv

  // show big profile 
  static Container ContainerPersonProfile() {
    return Container(
      color: Colors.grey[900],
      child: Padding(
        padding: EdgeInsets.only(top: 30),
        child: Center(
          child: Container(
            width: 170,
            height: 170,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/everyone's profile.jpg"),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // set text style (information)
  // info - text to display
  static Text infoText(String info) {
    return Text(
      info,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Colors.grey[900],
      ),
    );
  }

  // set text style (title)
  // title - text to display
  static Text titleText(String title) {
    return Text(
      '$title :',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.deepPurple,
      ),
    );
  }
}
