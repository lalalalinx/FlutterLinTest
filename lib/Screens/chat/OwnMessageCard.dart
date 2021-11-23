// ignore_for_file: file_names

import 'package:flutter/material.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({Key? key,required this.message,required this.time}) : super(key: key);
  final String message;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 150),
        child: Card(
          elevation:1,
          shape: RoundedRectangleBorder(
            borderRadius: 
            BorderRadius.circular(30),
            ),
            color: Colors.blue[400],
            margin: const EdgeInsets.only(left: 10.0, right: 10.0,top: 10),
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 45,
                  top: 10,
                  bottom: 10,
                ),
                child: Text(message,
                    style: TextStyle(
                      fontSize: 16,
                    )),
              ),
              Positioned(
                bottom: 4,
                right: 13,
                child: Row(children: [
                  Text(
                    time.hour.toString() + ":" + time.minute.toString(),
                      style: TextStyle(fontSize: 13, color: Colors.blue[800])),
                  SizedBox(width:5),
                  
                ]),
              ),
            ])),
      ),
    );
  }
}


