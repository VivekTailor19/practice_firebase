import 'package:flutter/material.dart';
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

}