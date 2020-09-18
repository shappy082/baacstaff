import 'package:baacstaff/utils/utility.dart';
import 'package:flutter/material.dart';

class SetPasswordScreen extends StatefulWidget {
  SetPasswordScreen({Key key}) : super(key: key);

  @override
  _SetPasswordScreenState createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  // สร้างตัวแปรสำหรับผูกกับฟอร์ม
  final formKey = GlobalKey<FormState>();

  // สร้างตัวแปรไว้รับค่าจากฟอร์ม
  String passwordText, passwordConfirmText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("Set your password")),
      ),
      resizeToAvoidBottomPadding: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          child: Form(
              key: formKey,
              child: ListView(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 50),
                    child: TextFormField(
                      autofocus: false,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 24, color: Colors.teal),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.lock,
                          size: 28,
                        ),
                        labelText: 'New password',
                        errorStyle: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter password';
                        } else if (value.length != 6) {
                          return 'Password must have 6 digits';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        passwordText = value.trim();
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: TextFormField(
                      autofocus: false,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 24, color: Colors.teal),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.lock,
                          size: 28,
                        ),
                        labelText: 'Retype your password',
                        errorStyle: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter password';
                        } else if (value.length != 6) {
                          return 'Password must have 6 digits';
                        } else if (passwordConfirmText != passwordText) {
                          Utility.getInstance().showAlertDialog(
                            context,
                            'Error',
                            'Both password does not match.',
                          );
                          return 'not match';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        passwordConfirmText = value.trim();
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                      right: 30,
                      top: 10,
                    ),
                    child: RaisedButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          Navigator.pushReplacementNamed(context, '/dashboard');
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      color: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
