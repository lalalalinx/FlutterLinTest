// ignore_for_file: file_names, unused_element, dead_code, prefer_const_constructors

import 'package:flutter/material.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard({Key? key,required this.message,required this.time}) : super(key: key);
  final String message;
  final DateTime time;

@override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: 
      Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(width: 10),
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.pinkAccent[100],
              ),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.all(10),
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width *0.6),
                child: Text(message,style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  )),
                decoration: BoxDecoration(
                  color: Colors.grey[200], /**** */
                  borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), 
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(1), //**** */
                  bottomRight: Radius.circular(12),
                  )),
              ),
            ],),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start, //*****
                children: [
                  SizedBox(width: 50),
                  Text(time.hour.toString() + ":" + time.minute.toString(),
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12,
                    letterSpacing: 2,
                    ),)
                ],
              ),
            ),
        ],
      ),
    );
  }
}
