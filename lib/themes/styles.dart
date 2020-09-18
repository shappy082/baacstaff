import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: 'Kanit',
    primarySwatch: Colors.red,
    accentColor: Colors.blueAccent,
    buttonColor: Colors.lightGreen,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.redAccent,
      unselectedItemColor: Colors.grey,
    ),
  );
}
