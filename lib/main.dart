import 'dart:io';

import 'package:baacstaff/routers.dart';
import 'package:baacstaff/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var storeStep;
var initURL;
Future main() async {
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

class BaacApp extends StatelessWidget {
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
