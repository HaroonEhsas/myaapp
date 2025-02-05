import 'package:flutter/foundation.dart'; // For debugPrint
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Initialize notifications
  Future<void> initialize() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        debugPrint("Notifications enabled");
      }
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        debugPrint("Received notification: ${message.notification?.title}");
      }
    });
  }

  // Get the FCM token
  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }
}