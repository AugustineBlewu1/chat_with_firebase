import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

class LocalNotification {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void setUp() async {
    const AndroidInitializationSettings androidinitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    // final IOSInitializationSettings initializationSettingsIOS =
    //     IOSInitializationSettings(
    //         requestAlertPermission: true,
    //         requestBadgePermission: true,
    //         requestSoundPermission: true,
    //         onDidReceiveLocalNotification: onReceivedLocalNotificationChnnel);

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidinitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future onReceivedLocalNotificationChnnel(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    
    final ide = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    this._showNotification(ide, notification!.title!, notification.body!, message.data['key']);
  }

  Future _showNotification(
      int id, String title, String body, String payLoad) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("keknotification", "KEK",
            channelDescription: "kek channel for displaying notification",
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    const NotificationDetails platformChannel =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id, title, body, platformChannel,
        payload: payLoad);
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      print(payload);
    }
  }

  // showMessageFromFirebase(
  //     RemoteMessage message, AndroidNotificationChannel channel) {
  //   RemoteNotification? notification = message.notification;
  //   AndroidNotification? android = message.notification?.android;

  //   if (notification != null && android != null) {
  //     flutterLocalNotificationsPlugin.show(
  //         notification.hashCode,
  //         notification.title,
  //         notification.body,
  //         NotificationDetails(
  //             android: AndroidNotificationDetails(channel.id, channel.name,
  //                 channelDescription: channel.description)));
  //   }
  // }
}
