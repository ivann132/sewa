import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Message received in background: ${message.notification?.title}');
}

class FirebaseMessagingHandler {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  static const AndroidNotificationChannel androidChannel = AndroidNotificationChannel(
    'channel_notification', // ID for the channel
    'High Importance Notification', // Channel name
    description: 'Used For Notification', // Channel description
    importance: Importance.high,
    playSound: true,
  );

  final FlutterLocalNotificationsPlugin localNotification = FlutterLocalNotificationsPlugin();

  Future<void> initPushNotification() async {
    // Request user permissions
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    // Retrieve and print FCM token
    final token = await messaging.getToken();
    print('FCM Token: $token');

    // Handle notification when app is terminated
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print('Notification when app is terminated: ${message.notification?.title}');
      }
    });

    // Set up background message handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      localNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            androidChannel.id,
            androidChannel.name,
            channelDescription: androidChannel.description,
            importance: Importance.high,
            playSound: true,
            sound: const RawResourceAndroidNotificationSound('soundringtone'),
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );

      print('Message received in foreground: ${notification.title}');
    });

    // Handle notification tap when app is in background or opened
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification tapped: ${message.notification?.title}');
    });
  }

  Future<void> initLocalNotification() async {
    // iOS settings
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings();

    // Android settings
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    // Initialize local notifications
    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await localNotification.initialize(settings);
  }
}
