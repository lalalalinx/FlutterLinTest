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
        child: Stack(
          children: [
            Card(
              elevation: 1,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              color: Colors.grey[200],
              margin: EdgeInsets.only(left: 10.0, right: 35.0,top: 10,bottom: 10),
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text("Hey", //<------------------------------*****
                      style: TextStyle(
                        fontSize: 16,
                      ),),
                    ),
                ])),
                Positioned(
                  bottom: 8,
                  left: 10,
                  child: Row(children: [
                Text(" 02:30 ", //<---------------------------------------*******
                    style: TextStyle(fontSize: 13, color: Colors.grey, backgroundColor: Colors.black)),
                SizedBox(width: 5),
              ])
            ),
          ],
        ),
      ),
    );
  }
}