// ignore_for_file: file_names
// not in use

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationAPI {
  static final notification = FlutterLocalNotificationsPlugin();

  static Future notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        importance: Importance.max)
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,

  }) async => notification.show(id, title, body, await notificationDetails(),payload: payload);
  
  // waitingAction
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