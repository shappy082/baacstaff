import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Image(
                  image: AssetImage('assets/images/trex.png'),
                  width: 150,
                  height: 150,
                ),
                // Text(
                //   'Register',
                //   style: TextStyle(fontSize: 30),
                // )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                color: Colors.white54,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            size: 20,
                          ),
                          labelText: 'Username',
                          hintText: 'Username',
                        ),
                      ),
                      TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.portrait,
                            size: 20,
                          ),
                          labelText: 'National ID',
                          hintText: '13 digits only',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/consent');
              },
              color: Colors.red,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  'Conspire',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            )
          ],
        ),
      ),
    );
  }
}
