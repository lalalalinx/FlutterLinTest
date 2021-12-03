// ignore_for_file: file_names, prefer_const_constructors
// own message card
import 'package:flutter/material.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({Key? key, required this.message, required this.time})
      : super(key: key);
  final String message;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6),
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(1),
                  ),
                ),
              ),
              SizedBox(width: 10),
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.yellow[800],
              ),
              SizedBox(width: 10),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  time.hour.toString() + ":" + time.minute.toString(),
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(width: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
