import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService
{
  static final service = NotificationService._();
  NotificationService._();

  FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification()
  async {
    AndroidInitializationSettings androidInit = AndroidInitializationSettings('logo');
    DarwinInitializationSettings iOSInit = DarwinInitializationSettings();

    InitializationSettings initializationSettings =
    InitializationSettings( android: androidInit, iOS: iOSInit );

    await notificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();

  }

  void simpleNotification()
  {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails("1", "simple",
        priority: Priority.high, importance: Importance.max,
        sound: RawResourceAndroidNotificationSound('baburao') );

    DarwinNotificationDetails iOSDetails = DarwinNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails( android:  androidDetails, iOS:  iOSDetails);

    notificationsPlugin.show(3, 
        "Simple Testing",
        "The item you selected is Deleted From the FireStore",
        notificationDetails);
  }

  void timeNotification()
  {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails("10",
        "Schedule",
        priority: Priority.high,importance: Importance.max,
        sound: RawResourceAndroidNotificationSound('khopdi')
    );

    DarwinNotificationDetails iOSDetails = DarwinNotificationDetails();

    NotificationDetails notificationDetails =
    NotificationDetails( android:  androidDetails, iOS:  iOSDetails);

    notificationsPlugin.zonedSchedule(6 ,
      "Schedule Testing",
      "The item you selected is Updated From the FireStore",
      tz.TZDateTime.now(tz.local).add(Duration(seconds: 3)),
      notificationDetails,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, );

  }

  Future<void> pictureNotification()
  async {

    Uint8List img= await _getByteArrayFromUrl('https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg');

    ByteArrayAndroidBitmap bigImage= ByteArrayAndroidBitmap(img);

    BigPictureStyleInformation big = BigPictureStyleInformation(bigImage);

    AndroidNotificationDetails android = AndroidNotificationDetails("11", "big",
    styleInformation:  big,
      priority: Priority.high,
      importance: Importance.max
    );

    NotificationDetails notificationDetails = NotificationDetails(android: android);

    await notificationsPlugin.show(12, "Testing BIG PICTURE", "Flutter BIG", notificationDetails);

  }

  Future<Uint8List> _getByteArrayFromUrl(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }



}