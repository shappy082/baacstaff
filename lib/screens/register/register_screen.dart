import 'dart:convert';

import 'package:baacstaff/utils/utility.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:baacstaff/models/register_model.dart';
import 'package:baacstaff/services/rest_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            initialValue: "5601965",
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
                            initialValue: "7127225663620",
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter National ID";
                              } else if (value.length != 13) {
                                return "Value must be 13 digits";
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
                      var data = {"empid": empID, "cizid": cizID};
                      _register(data);
                    }
                  },
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    child: Text(
                      'Conspire',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
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
    var isOffline = await Connectivity().checkConnectivity();
    if (isOffline == ConnectivityResult.none) {
      Utility.getInstance().showAlertDialog(
          context, "Offline", "Please connect to the Internet.");
    } else {
      var response = await CallAPI().postData(data, "/register");
      var body = json.decode(response.body);
      // print(body['code']);
      if (body['code'] == "200") {
        // create SharedPreferences
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        //stored data to sharedPreferences
        sharedPreferences.setString('store_empID', body['data']['empid']);
        sharedPreferences.setString('store_prename', body['data']['prename']);
        sharedPreferences.setString(
            'store_firstname', body['data']['firstname']);
        sharedPreferences.setString('store_lastname', body['data']['lastname']);
        sharedPreferences.setString('store_position', body['data']['position']);
        sharedPreferences.setInt('store_step', 1);

        Navigator.pushNamed(context, '/consent');
      }
    }
  }
}
