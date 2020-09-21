import 'package:baacstaff/screens/consent/consent_screen.dart';
import 'package:baacstaff/screens/dashboard/dashboard_screen.dart';
import 'package:baacstaff/screens/drawer/cancel_account/cancel_account_screen.dart';
import 'package:baacstaff/screens/drawer/news/news_screen.dart';
import 'package:baacstaff/screens/employee_detail/employee_detail_screen.dart';
import 'package:baacstaff/screens/lockscreen/lock_screen.dart';
import 'package:baacstaff/screens/pincode/pincode_screen.dart';
import 'package:baacstaff/screens/register/register_screen.dart';
import 'package:baacstaff/screens/setPassword/setPassword_screen.dart';
import 'package:baacstaff/screens/welcome/welcomeScreen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/welcome": (BuildContext context) => WelcomeScreen(),
  "/register": (BuildContext context) => RegisterScreen(),
  "/consent": (BuildContext context) => ConcentScreen(),
  "/pin": (BuildContext context) => PincodeScreen(),
  "/setpassword": (BuildContext context) => SetPasswordScreen(),
  "/dashboard": (BuildContext context) => DashboardScreen(),
  "/news": (BuildContext context) => NewsScreen(),
  "/cancelAcc": (BuildContext context) => CancelAccountScreen(),
  "/lockscreen": (BuildContext context) => LockScreen(),
  "/employee-detail": (BuildContext context) => EmployeeDetailScreen(),
};
