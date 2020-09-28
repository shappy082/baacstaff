import 'dart:io';

import 'package:baacstaff/functions/PushNotificationManager.dart';
import 'package:baacstaff/routers.dart';
import 'package:baacstaff/themes/styles.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var storeStep;
var initURL;
Future main() async {
  // // Call push notification manager
  // PushNotificationManager pushNotificationManager;
  // await pushNotificationManager.init();

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  storeStep = sharedPreferences.getInt('store_step');
  if (storeStep == 1) {
    initURL = '/pin';
  } else if (storeStep == 2) {
    initURL = '/setpassword';
  } else if (storeStep == 3) {
    initURL = '/dashboard';
  } else if (storeStep == 4) {
    initURL = '/lockscreen';
  } else {
    initURL = '/welcome';
  }
  HttpOverrides.global = new MyHttpOverrides();
  runApp(BaacApp());
}

class BaacApp extends StatefulWidget {
  BaacApp({Key key}) : super(key: key);

  @override
  _BaacAppState createState() => _BaacAppState();
}

class _BaacAppState extends State<BaacApp> {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  void initFirebaseMessaging() {
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );

    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("Token : $token");
    });
  }

  @override
  void initState() {
    super.initState();
    initFirebaseMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      initialRoute: initURL,
      routes: routes,
    );
  }
}

// class BaacApp extends StatelessWidget {
//   // Call push notification manager

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: appTheme(),
//       initialRoute: initURL,
//       routes: routes,
//     );
//   }
// }

//NOT DO THIS IN REAL APP
//skip certificate https
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
