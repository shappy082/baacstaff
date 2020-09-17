import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:baacstaff/models/register_model.dart';
import 'package:baacstaff/services/rest_api.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // create var for Form
  final formKey = GlobalKey<FormState>();
  // create var for recieve data
  String empID, cizID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 100),
          child: Form(
            key: formKey,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter username";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              empID = value.trim();
                            },
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
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter National ID";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              cizID = value.trim();
                            },
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
                    // Navigator.pushNamed(context, '/consent');
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      var data = {'empID': empID, 'cizid': cizID};
                      _register(data);
                    }
                  },
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
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
        ),
      ),
    );
  }

  // function check api
  void _register(data) async {
    // print(jsonEncode(data));
    var response = await CallAPI().postData(jsonEncode(data), "/register");
    var body = json.decode(response.body);
    print(body);
  }
}
