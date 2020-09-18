import 'package:flutter/material.dart';

class CheckInScreen extends StatefulWidget {
  CheckInScreen({Key key}) : super(key: key);

  @override
  _CheckInScreenState createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Check-in Body'),
      ),
    );
  }
}
