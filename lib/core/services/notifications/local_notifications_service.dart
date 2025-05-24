import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

@pragma('vm:entry-point')
class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
      StreamController();

  @pragma('vm:entry-point')
  static onTap(NotificationResponse notificationResponse) {
    // log(notificationResponse.id!.toString());
    // log(notificationResponse.payload!.toString());
    streamController.add(notificationResponse);
    // Navigator.push(context, route);
  }

  @pragma('vm:entry-point')
  static Future init() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  //basic Notification
  @pragma('vm:entry-point')
  static void showBasicNotification(RemoteMessage message) async {
    try {
      // Check if an image URL is provided
      if (message.notification?.android?.imageUrl != null &&
          message.notification!.android!.imageUrl!.isNotEmpty) {
        await _showNotificationWithImage(message);
      } else {
        // Show a simple notification without an image
        await _showSimpleNotification(message);
      }
    } catch (e) {
      print('Error showing local notification: $e');
      // Fallback to simple notification if image loading fails
      await _showSimpleNotification(message);
    }
  }

  @pragma('vm:entry-point')
  static Future<void> _showNotificationWithImage(RemoteMessage message) async {
    try {
      final http.Response image = await http
          .get(Uri.parse(message.notification?.android?.imageUrl ?? ''));

      BigPictureStyleInformation bigPictureStyleInformation =
          BigPictureStyleInformation(
        ByteArrayAndroidBitmap.fromBase64String(
          base64Encode(image.bodyBytes),
        ),
        largeIcon: ByteArrayAndroidBitmap.fromBase64String(
          base64Encode(image.bodyBytes),
        ),
      );

      AndroidNotificationDetails android = AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        importance: Importance.max,
        priority: Priority.high,
        styleInformation: bigPictureStyleInformation,
        playSound: true,
      );

      NotificationDetails details = NotificationDetails(
        android: android,
        iOS: const DarwinNotificationDetails(
          presentSound: true,
          sound: 'custom_sound.caf',
        ),
      );

      await flutterLocalNotificationsPlugin.show(
        message.hashCode, // Use a unique ID
        message.notification?.title,
        message.notification?.body,
        details,
        payload: jsonEncode(message.data),
      );
    } catch (e) {
      print('Error showing notification with image: $e');
      await _showSimpleNotification(message);
    }
  }

  @pragma('vm:entry-point')
  static Future<void> _showSimpleNotification(RemoteMessage message) async {
    AndroidNotificationDetails android = const AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    NotificationDetails details = NotificationDetails(
      android: android,
      iOS: const DarwinNotificationDetails(
        presentSound: true,
        sound: 'custom_sound.caf',
      ),
    );

    await flutterLocalNotificationsPlugin.show(
      message.hashCode, // Use a unique ID
      message.notification?.title,
      message.notification?.body,
      details,
      payload: jsonEncode(message.data),
    );
  }
}
