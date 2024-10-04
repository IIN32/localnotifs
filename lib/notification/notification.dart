import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService{
  //Initialization
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> onDidReceiveNotification(NotificationResponse notificationResponse) async{}
  //Initialize the notification plugin
  static Future<void> init() async{
    //Define android initialization settings
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings("@mipmap/ic_launcher");

    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );

    //Initilize plugin with the specified seetings
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
      onDidReceiveNotificationResponse:onDidReceiveNotification,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveNotification,
    );

    //Request notification permission for android
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }
  //Show an instant notification
  static Future<void> showInstantNotification(String title, String body, int id) async{
    //Details
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: AndroidNotificationDetails(
          "Channel_Id",
          "Channel_Name",
          channelDescription: 'Notifications for upcoming reminders and tasks.',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails()
    );
    await flutterLocalNotificationsPlugin.show(id, title, body, platformChannelSpecifics);
  }


  //Scheduled notification
  static Future<void> scheduleNotification(int id,String title, String body, DateTime scheduledTime, {required largeIcon, required smallIcon}) async {
    //Details
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: AndroidNotificationDetails(
          "Channel_Id",
          "Channel_Name",
          channelDescription: 'Notifications for upcoming reminders and tasks.',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails()
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id, title, body, tz.TZDateTime.from(scheduledTime, tz.local),
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation
            .absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime);
  }

    static Future<void> cancelNotification(int id) async {
    try {
      await flutterLocalNotificationsPlugin.cancel(id); // Cancel a specific notification
    } catch (e) {
      // Handle potential errors here
      print('Error canceling notifications: $e');
    }
  }
}























// import 'package:flutter/material.dart';
// import 'package:timezone/timezone.dart' as tz;
//
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationService{
//   //Initialization
//   static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   static Future<void> onDidReceiveNotification(NotificationResponse notificationResponse) async{}
//   //Initialize the notification plugin
//   static Future<void> init() async{
//     //Define android initialization settings
//     const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings("@mipmap/ic_launcher");
//
//     const InitializationSettings initializationSettings = InitializationSettings(
//       android: androidInitializationSettings,
//     );
//
//     //Initilize plugin with the specified seetings
//     await flutterLocalNotificationsPlugin.initialize(
//         initializationSettings,
//       onDidReceiveNotificationResponse:onDidReceiveNotification,
//       onDidReceiveBackgroundNotificationResponse: onDidReceiveNotification,
//     );
//
//     //Request notification permission for android
//     await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//         ?.requestNotificationsPermission();
//   }
//   //Show an instant notification
//   static Future<void> showInstantNotification(String title, String body) async{
//     //Details
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//         android: AndroidNotificationDetails(
//         "Channel_Id",
//         "Channel_Name",
//           channelDescription: 'Notifications for upcoming reminders and tasks.',
//           importance: Importance.high,
//           priority: Priority.high,
//         ),
//             iOS: DarwinNotificationDetails()
//     );
//     await flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics);
//   }
//
//
//   //Scheduled notification
//   static Future<void> scheduleNotification(int id,String title, String body, DateTime scheduledTime) async{
//     //Details
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//         android: AndroidNotificationDetails(
//           "Channel_Id",
//           "Channel_Name",
//           channelDescription: 'Notifications for upcoming reminders and tasks.',
//           importance: Importance.high,
//           priority: Priority.high,
//         ),
//         iOS: DarwinNotificationDetails()
//     );
//     await flutterLocalNotificationsPlugin.zonedSchedule(0, title, body, tz.TZDateTime.from(scheduledTime, tz.local), platformChannelSpecifics,
//     uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//     matchDateTimeComponents: DateTimeComponents.dateAndTime);
//   }
//
//   static Future<void> cancelNotification(int id) async {
//     try {
//       await flutterLocalNotificationsPlugin.cancel(id); // Cancel a specific notification
//     } catch (e) {
//       // Handle potential errors here
//       print('Error canceling notifications: $e');
//     }
//   }
// }