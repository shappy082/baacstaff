import 'package:baacstaff/routers.dart';
import 'package:baacstaff/themes/styles.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BaacApp());
}

class BaacApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      initialRoute: '/welcome',
      routes: routes,
    );
  }
}
