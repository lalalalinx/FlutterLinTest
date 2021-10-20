// ignore_for_file: file_names

import 'package:flutter/material.dart';
class HomeView extends StatefulWidget {

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  
  List<String> quotes = [
    '11111111111',
    '22222',
    '33' 
  ];
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[600], 
      ),
    );
  }
}
