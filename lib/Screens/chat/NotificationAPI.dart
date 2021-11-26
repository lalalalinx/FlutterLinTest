// ignore_for_file: file_names

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
  
}