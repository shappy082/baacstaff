import 'package:baacstaff/screens/lockscreen/numpad.dart';
import 'package:baacstaff/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LockScreen extends StatefulWidget {
  LockScreen({Key key}) : super(key: key);

  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  int length = 6;

  onChange(String number) {
    if (number.length == length) {
      _login(number);
    }
  }

  _login(String passwordInput) async {
    // create var for sharedPreferences
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var password = sharedPreferences.getString('store_password');
    if (passwordInput == password) {
      sharedPreferences.setInt('store_step', 3);
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      Utility.getInstance()
          .showAlertDialog(context, "Wrong Password!", "Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Lock Screen'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Padding(
            //         padding: const EdgeInsets.only(right: 20),
            //         child:
            //             IconButton(icon: Icon(Icons.close), onPressed: () {})),
            //   ],
            // ),
            Image.asset(
              'assets/images/trex.png',
              width: 80,
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                'กรุณาใส่รหัสผ่าน',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
            Numpad(
              length: length,
              onChange: onChange,
            )
          ],
        ),
      ),
    );
  }
}
