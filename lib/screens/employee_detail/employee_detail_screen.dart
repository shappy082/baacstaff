import 'package:baacstaff/models/register_model.dart';
import 'package:baacstaff/services/rest_api.dart';
import 'package:baacstaff/utils/utility.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmployeeDetailScreen extends StatefulWidget {
  EmployeeDetailScreen({Key key}) : super(key: key);

  @override
  _EmployeeDetailScreenState createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  // Call Model
  RegisterModel _employeeData;
  @override
  void initState() {
    super.initState();
    _readEmployeeData();
  }

  // Call API
  _readEmployeeData() async {
    var isOffline = await Connectivity().checkConnectivity();
    if (isOffline == ConnectivityResult.none) {
      Utility.getInstance().showAlertDialog(
          context, "Offline", "Please connect to the Internet.");
    } else {
      var empData = {"empid": "5601965", "cizid": "7127225663620"};
      var response = await CallAPI().getEmployee(empData);
      setState(() {
        _employeeData = response;
      });
    }
  }

  final df = new DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Name"),
            subtitle: Text(_employeeData.data.firstname +
                ' ' +
                _employeeData.data.lastname),
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text("Employee ID"),
            subtitle: Text(_employeeData.data.empid),
          ),
          ListTile(
            leading: Icon(Icons.favorite_border),
            title: Text("Sex"),
            subtitle: Text(_employeeData.data.gender),
          ),
          ListTile(
            leading: Icon(Icons.business),
            title: Text("Department"),
            subtitle: Text(_employeeData.data.department),
          ),
          ListTile(
            leading: Icon(Icons.work),
            title: Text("Position"),
            subtitle: Text(_employeeData.data.position),
          ),
          ListTile(
            leading: Icon(Icons.local_atm),
            title: Text("Salary"),
            subtitle: Text(NumberFormat.currency(locale: "th_TH")
                .format(double.parse(_employeeData.data.salary))),
          ),
          ListTile(
            leading: Icon(Icons.cake),
            title: Text("Birthdate"),
            subtitle: Text(DateFormat("dd MMMM yyyy")
                .format(_employeeData.data.birthdate.toUtc())),
          ),
          ListTile(
            leading: Icon(Icons.mail_outline),
            title: Text("Email"),
            subtitle: Text(_employeeData.data.email),
          ),
          ListTile(
            leading: Icon(Icons.phone_android),
            title: Text("Telephone"),
            subtitle: Text(_employeeData.data.tel),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Address"),
            subtitle: Text(_employeeData.data.address),
          ),
        ],
      ),
    );
  }
}
