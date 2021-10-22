// ignore_for_file: file_names

import 'package:flutter/material.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
        child: Stack(
          children: [
            Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                color: Colors.blue,
                margin: EdgeInsets.only(
                    left: 35.0, right: 10.0, top: 10, bottom: 10),
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                    bottom: 10,
                    ),
                    child:
                        Text("Hey", //<----------------------------------******
                            style: TextStyle(
                              fontSize: 16,
                            )),
                  ),
                ])),
            Positioned(
              bottom: 8,
              right: 75,
              child: Row(children: [
                Text("2:04", //<---------------------------------------*******
                    style: TextStyle(fontSize: 13, color: Colors.white)),
                SizedBox(width: 5),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
