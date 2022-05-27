import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:pmpconstractions/core/featuers/notification/services/navigation_service.dart';

class NotificationService {
  //NotificationService a singleton object
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channelId = '123';

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('launch_background');

    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) {
      selectNotification(payload);
    });
  }

  final AndroidNotificationDetails _androidNotificationDetails =
      const AndroidNotificationDetails(
    'channel ID',
    'channel name',
    playSound: true,
    priority: Priority.max,
    importance: Importance.max,
    //  ledColor: Colors.orange,
    enableLights: true,
    color: Colors.orange,
    enableVibration: true,
    icon: 'res_notification_app_icon1',
    largeIcon: DrawableResourceAndroidBitmap('res_notification_app_icon1'),
  );

  Future<void> showNotifications(
      {required int id,
      required String title,
      required String body,
      required pauload}) async {
    await flutterLocalNotificationsPlugin.show(id, title, body,
        NotificationDetails(android: _androidNotificationDetails),
        payload: '/notification');
  }

  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

Future selectNotification(String? payload) async {
  NavigationService().navigateTo(routeName: '/notification');
}
