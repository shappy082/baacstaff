import 'package:baacstaff/screens/consent/consent_screen.dart';
import 'package:baacstaff/screens/pincode/pincode_screen.dart';
import 'package:baacstaff/screens/register/register_screen.dart';
import 'package:baacstaff/screens/welcome/welcomeScreen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/welcome": (BuildContext context) => WelcomeScreen(),
  "/register": (BuildContext context) => RegisterScreen(),
  "/consent": (BuildContext context) => ConcentScreen(),
  "/pin": (BuildContext context) => PincodeScreen(),
};
