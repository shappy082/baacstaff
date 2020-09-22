import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome to INSIDER",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              fontFamily: 'Consolas',
            ),
          ),
          Center(
            child: Icon(
              Icons.visibility,
              size: 200,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/register');
              // Navigator.pushReplacementNamed(context, '/register');
            },
            color: Colors.red,
            splashColor: Colors.redAccent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Close your eyes',
                style: TextStyle(fontSize: 30),
              ),
            ),
          )
        ],
      ),
    );
  }
}
