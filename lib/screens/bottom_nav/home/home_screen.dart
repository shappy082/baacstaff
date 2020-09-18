import 'package:flutter/material.dart';

class HomeAccountScreen extends StatefulWidget {
  HomeAccountScreen({Key key}) : super(key: key);

  @override
  _HomeAccountScreenState createState() => _HomeAccountScreenState();
}

class _HomeAccountScreenState extends State<HomeAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home Body'),
      ),
    );
  }
}
