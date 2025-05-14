import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import 'dart:convert';


import '../../../styling/app_color.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Initialize everything related to Firebase Messaging
  Future<void> firebaseInit() async {
    // Set the background message handler first
    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

    // Foreground notifications
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      print("Foreground Notification: ${notification?.title}");
      if (notification != null) {
        showNotification(message);
      }
    });

    // When app is in background and user taps notification
    FirebaseMessaging.onMessageOpenedApp.listen((bgMessage) {
      print("Notification Opened (Background): ${bgMessage.messageId}");
      handlerMessage(bgMessage);
    });

    // When app is terminated and opened via notification
    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      print("Notification from Terminated State: ${initialMessage.data}");
      handlerMessage(initialMessage);
    }

    // Ask permission
    await requestNotificationPermission();

    // Initialize local notifications
   // initLocalNotification();
  }

  /// Ask user for notification permission
  Future<void> requestNotificationPermission() async {
    try {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print("User granted permission");
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print("User granted provisional permission");
        Get.snackbar(
          "Provisional Permission Granted",
          "You will receive notifications, but they may be limited.",
          snackPosition: SnackPosition.TOP,
        );
      } else {
        Get.snackbar(
          "Notification Permission Denied",
          "Please allow notifications to receive updates.",
          snackPosition: SnackPosition.TOP,
        );
        Future.delayed(Duration(seconds: 2), () {
          AppSettings.openAppSettings(type: AppSettingsType.notification);
        });
      }
    } catch (e) {
      print("Error requesting notification permission: $e");
      Get.snackbar("Error", "Failed to request notification permission.",
          snackPosition: SnackPosition.TOP);
    }
  }



  /// Show local notification (when app is in foreground)
  /// Show local notification (when app is in foreground)
  void showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

    if (notification != null && android != null) {
      // Show local notification
      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        platformDetails,
        payload: jsonEncode(message.data),
      );

      // Show snackbar using GetX
      Get.snackbar(
        notification.title ?? "Notification",
        notification.body ?? "",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 4),
        backgroundColor:AppColor.blue,
        colorText:AppColor.white
      );
    }
  }

  /* void showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
        icon: '@mipmap/ic_launcher'
    );

    const NotificationDetails platformDetails =
    NotificationDetails(android: androidDetails);

    if (notification != null && android != null) {
      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        platformDetails,
        payload: jsonEncode(message.data),
      );
    }
  }*/

  /// When user taps on notification
  void handlerMessage(RemoteMessage message) {
    if (message.data.containsKey('route')) {
      String route = message.data['route'];
      Get.toNamed(route); // Navigate using GetX
    } else {
      Get.snackbar("Notification Clicked", "No route found in notification.");
    }
  }

/*  /// Local notification initialization
  void initLocalNotification() {
    const AndroidInitializationSettings androidInit =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initSettings =
    InitializationSettings(android: androidInit);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: (payload) async {
          if (payload != null) {
            final data = jsonDecode(payload);
            if (data['route'] != null) {
              Get.toNamed(data['route']);
            }
          }
        });
  }*/
}

/// Background message handler
@pragma('vm:entry-point')
Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  print("Background Message Handler: ${message.messageId}");
}

