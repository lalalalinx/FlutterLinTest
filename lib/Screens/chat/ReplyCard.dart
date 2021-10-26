// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard({Key? key,required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width -150),
        child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            color: Colors.grey[100],
            margin: const EdgeInsets.only(left: 10.0, right: 10.0,top: 10),
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 42,
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
                right:14,
                child: Text("2:04",
                    style: TextStyle(fontSize: 13, color: Colors.grey[600])),
              ),
            ])),
      ),
    );
  }
}
