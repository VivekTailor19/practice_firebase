import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
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

// ======================           picture Notification   ByteArrayFromUrl  =============================
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

// ======================           picture Notification  download & savefile  =============================

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> bigPictureDownloadNotification()
  async {
    final String bigPicturePath = await _downloadAndSaveFile(
        'https://images.pexels.com/photos/1261728/pexels-photo-1261728.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 'bigPicture');

    final BigPictureStyleInformation bigPictureStyleInformation =
    BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
        contentTitle: 'overridden <b>big</b> content title',
        htmlFormatContentTitle: true,
        summaryText: 'summary <i>text</i>',
        htmlFormatSummaryText: true);

    AndroidNotificationDetails androidDetails = AndroidNotificationDetails("15", "Picture Notification Down&Save",
        priority: Priority.high,importance: Importance.max,styleInformation: bigPictureStyleInformation);

    NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    await notificationsPlugin.show(15, "Picture Down&Save", "Picture Add Successfully", notificationDetails);
  }


// ======================           fire notification bro  =============================

  void fireNotification({title,body})
  {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails("16", "fire",
        priority: Priority.high, importance: Importance.max,
         );

    DarwinNotificationDetails iOSDetails = DarwinNotificationDetails();

    NotificationDetails notificationDetails =
    NotificationDetails( android:  androidDetails, iOS:  iOSDetails);

    notificationsPlugin.show(3,
        "$title",
        "$body",
        notificationDetails);
  }


}