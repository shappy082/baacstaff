import 'package:baacstaff/routers.dart';
import 'package:baacstaff/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var _empID;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  _empID = sharedPreferences.getString('store_empID');
  runApp(BaacApp());
}

class BaacApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      initialRoute: _empID == null ? '/welcome' : '/dashboard',
      routes: routes,
    );
  }
}
