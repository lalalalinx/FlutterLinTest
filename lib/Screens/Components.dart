// ignore_for_file: file_names, sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Components{
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
}