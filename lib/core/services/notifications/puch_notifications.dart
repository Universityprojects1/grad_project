import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_proj/core/api/end_points.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../cache/storage_token.dart';
import '../../di/service_locator.dart';
import 'local_notifications_service.dart';

@pragma('vm:entry-point')
class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? fcmToken;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future init() async {
    await messaging.requestPermission();
    String? userId = await sl<StorageToken>().getToken();

    await messaging.getToken().then((value) {
      fcmToken = value;
      if (userId != null) {
        sendTokenToServer(userId);
      }
    });

    messaging.onTokenRefresh.listen((value) {
      fcmToken = value;
      if (userId != null) {
        sendTokenToServer(userId);
      }
    });

    if (userId != null) {
      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
      handleForegroundMessage(userId);
    }

    messaging.subscribeToTopic('all').then((val) {
      log('sub');
    });
  }

  @pragma('vm:entry-point')
  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
  }

  static void handleForegroundMessage(String id) {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        // show local notification
        LocalNotificationService.showBasicNotification(
          message,
        );
      },
    );
  }

  static void sendTokenToServer(String token) async {
    firestore.collection(EndPoints.users).doc(token).update({
      'fcmToken': fcmToken,
    });
  }
}
/*
  1.Permissions [done]
  2.fcm token [done]
  3.test using token with Firebase [done]
  4.fire notification [background] [done]
  5.fire notification [killed] [done]
  6.fire notification [foreground] [done]
  7.test using token with Postman [done]
  8.send Image with notification [done]
  9.send notification with custom sound [done]
  10.send token to server [done]
  11.topic [done]
 */
