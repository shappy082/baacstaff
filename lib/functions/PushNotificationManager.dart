import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class PushNotificationManager {
  PushNotificationManager._();

  factory PushNotificationManager() => _instance;

  static final PushNotificationManager _instance = PushNotificationManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;
  Future<void> init() async {
    if (_initialized) {
      //for iOS
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure();

      //read token
      String token = await _firebaseMessaging.getToken();
      print(token);
    }
  }
}
