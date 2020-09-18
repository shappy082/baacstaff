import 'package:flutter/material.dart';

class CancelAccountScreen extends StatefulWidget {
  CancelAccountScreen({Key key}) : super(key: key);

  @override
  _CancelAccountScreenState createState() => _CancelAccountScreenState();
}

class _CancelAccountScreenState extends State<CancelAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cancel Account'),
      ),
      body: Center(
        child: Text('Cancel Account Body'),
      ),
    );
  }
}
