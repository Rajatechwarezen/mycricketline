 
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tzt;
import 'package:timezone/timezone.dart' as tz;

import 'package:timezone/data/latest.dart' as tzl;

import '../../../push_notification_service.dart';

class NotiController {

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

 initializeNotifications()  {
      
tzl.initializeTimeZones();
PushNotificationService.requestPermissions();
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'));

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
  bool _notificationsEnabled = false;

  void showNotificationsList(List<String> scheduledTimes, String title, String body) async {
    for (String timeString in scheduledTimes) {
      // Convert timeString to DateTime
      DateTime scheduledDateTime = parseScheduledTime(timeString);

      // Schedule notification
      showNotification(scheduledDateTime, title, body);
    }
  }

  DateTime parseScheduledTime(String timeString) {
    // Parse the timeString and convert it to DateTime
    // You may use a library or manual parsing based on your specific time format
    // For simplicity, I assume timeString is in "hh:mm a / dd-MMM" format
    // Example: "05:00 AM / 17-Jan"
    // Implement your parsing logic accordingly

    // Example parsing using intl package:
    final format = DateFormat('hh:mm a / dd-MMM');
    return format.parse(timeString);
  }

  void showNotification(DateTime scheduledDateTime , String title, String body) async {
    final location = tzt.getLocation('Asia/Kolkata');
;


  await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'scheduled title',
        'scheduled body',
       tz.TZDateTime.from(scheduledDateTime, location),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id', 'your channel name',
                channelDescription: 'your channel description',
                   showWhen: false,
      importance: Importance.max,
      priority: Priority.high,
                
                )),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle :true,
        );
  
  }


}