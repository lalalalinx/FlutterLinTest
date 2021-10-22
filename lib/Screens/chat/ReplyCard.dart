// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
        child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: Colors.grey[400],
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 50,
                  top: 5,
                  bottom: 20,
                ),
                child: Text("Hey",
                    style: TextStyle(
                      fontSize: 16,
                    )),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Text("2:04",
                    style: TextStyle(fontSize: 13, color: Colors.grey[600])),
              ),
            ])),
      ),
    );
  }
}
