import 'package:baacstaff/utils/password_widget.dart';
import 'package:baacstaff/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                    child: PasswordField(
                      labelText: 'New password',
                      helperText: 'Enter 6 digits password',
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter password";
                        } else if (value.length != 6) {
                          return "Password must have 6 digits";
                        } else {
                          return null;
                        }
                      },
                      onFieldSubmitted: (String value) {
                        setState(() {
                          this.passwordText = value;
                        });
                      },
                      onSaved: (value) {
                        passwordText = value.trim();
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: PasswordField(
                      labelText: 'Confirm Password',
                      helperText: 'Enter 6 digits password',
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter password";
                        } else if (value.length != 6) {
                          return "Password must have 6 digits";
                        } else {
                          return null;
                        }
                      },
                      onFieldSubmitted: (String value) {
                        setState(() {
                          this.passwordConfirmText = value;
                        });
                      },
                      onSaved: (value) {
                        passwordConfirmText = value.trim();
                      },
                    ),
                  ),
                  SizedBox(height: 30),
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
                          if (passwordText != passwordConfirmText) {
                            Utility.getInstance().showAlertDialog(context,
                                "Password not match!", "Please try again");
                          } else {
                            _setpasswordSubmit(context, passwordText);
                          }
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

  void _setpasswordSubmit(BuildContext context, password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('store_step', 3);
    sharedPreferences.setString('store_password', password);
    Navigator.pushReplacementNamed(context, '/dashboard');
  }
}
