import 'package:chat/nav/navigators.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:chat/providers/notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late LocalNotification notification;
  late final AndroidNotificationChannel channel;

  NotificationService() {
    this.getToken();
    channel = AndroidNotificationChannel(
        'high_importance_channel', // id of channel
        'High Importance Notifications', // title of channel
        description: 'This channel is used for important notifications.',
        enableVibration: true,
        playSound: true,
        importance: Importance.max);

    _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    this.notification = LocalNotification();
  }

  Future<void> _requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      await _requestPermission();
    }
  }

  Future setUp() async {
    //  await _requestPermission();
    FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessage.listen((event) {
      if (event.notification != null) {
        //event -> message
        logger.w(event.notification!.body);
        logger.w(event.notification!.title);
        this.notification.onReceivedLocalNotificationChnnel(event);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      logger.w(event);
      if (event.notification != null) {
        logger.w(event.data);
        logger.v(event.data);
      }
    });
  }

  Future<String?> getToken() async {
    String? token = await _firebaseMessaging.getToken();
    return token;
  }
}
