import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:uuid/uuid.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

@pragma('vm:entry-point')
Future<String> getAccessToken() async {
  final jsonString = await rootBundle.loadString(
    'assets/notifications_key/exhend-app-5b78cafa3c93.json',
  );

  final accountCredentials =
      auth.ServiceAccountCredentials.fromJson(jsonString);

  final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
  final client = await auth.clientViaServiceAccount(accountCredentials, scopes);

  return client.credentials.accessToken.data;
}

@pragma('vm:entry-point')
Future<void> sendNotification(
    {required String token,
    required String id,
    required String title,
    required String body,
    required Map<String, String> data}) async {
  final String accessToken = await getAccessToken();
  const String fcmUrl =
      'https://fcm.googleapis.com/v1/projects/exhend-app/messages:send';

  await http.post(
    Uri.parse(fcmUrl),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    },
    body: jsonEncode(<String, dynamic>{
      'message': {
        'token': token,
        'notification': {
          'title': title,
          'body': body,
        },
        'data': data, // Add custom data here

        'android': {
          'notification': {
            "sound": "long_notification_sound",
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            // Required for tapping to trigger response
            'channel_id': 'channel_id'
          },
        },
        'apns': {
          'payload': {
            'aps': {"sound": "custom_sound.caf", 'content-available': 1},
          },
        },
      },
    }),
  );
  sendContentOfNotificationToServer(
      RemoteMessage(
          notification: RemoteNotification(title: title, body: body),
          data: data),
      id);
}

@pragma('vm:entry-point')
void handleNotification(BuildContext context, Map<String, dynamic> data) {
  String route = data['route'];
  String id = data['id'];

  // if (route == '/product_detials') {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => ProductDetailsScreen(productId: id)),
  //   );
  // }
}

Future<void> sendContentOfNotificationToServer(
    RemoteMessage message, String? userId) async {
  if (userId == null) return;
  var messageId = const Uuid().v4();
  final notificationData = {
    'title': message.notification?.title,
    'body': message.notification?.body,
    'data': message.data,
    'id': messageId,
    'timestamp': FieldValue.serverTimestamp(),
  };

  await firestore
      .collection(userId)
      .doc(messageId)
      .set(notificationData)
      .then((value) {
    log('Notification data sent to Firestore');
  }).catchError((error) {
    log('Failed to send notification data: $error');
  });
}
