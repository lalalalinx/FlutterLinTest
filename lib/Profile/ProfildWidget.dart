import 'dart:io';
// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, file_names

import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String image;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.image,
    required this.onClicked,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final color = Colors.black;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final imageProfile = NetworkImage(image);

    return Container(
      margin: new EdgeInsets.only(left: 0, top: 30, right: 0, bottom: 0),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: Ink.image(
            image: imageProfile,
            fit: BoxFit.cover,
            width: 128,
            height: 128,
            child: InkWell(onTap: onClicked), //<------------- กดรูป
          ),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
      color: Colors.white,
      all: 3,
      child: buildCircle(
        color: color,
        all: 8,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 20,
        ),
      ));

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
