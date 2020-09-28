import 'package:baacstaff/screens/bottom_nav/benefit/benefit_screen.dart';
import 'package:baacstaff/screens/bottom_nav/checkin/checkin_screen.dart';
import 'package:baacstaff/screens/bottom_nav/employee/employee_screen.dart';
import 'package:baacstaff/screens/bottom_nav/fundLoan/fund_loan_screen.dart';
import 'package:baacstaff/screens/bottom_nav/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // create SharedPreferences
  SharedPreferences sharedPreferences;

  // set variable to stored sharedPreferences value
  String _employeeName, _employeeEmpID;

  //initial state when this widget start
  @override
  void initState() {
    super.initState();
    readEmployee();
  }

  // create async function to read sharedPreferences
  readEmployee() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _employeeName = sharedPreferences.getString('store_prename') +
          sharedPreferences.getString('store_firstname') +
          ' ' +
          sharedPreferences.getString('store_lastname');
      _employeeEmpID = sharedPreferences.getString('store_empID');
    });
  }

  void _signOut() async {
    // create var for sharedPreferences
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('store_step', 4);
    Navigator.pushReplacementNamed(context, '/lockscreen');
  }

  //create list variable to stored bottom screen items
  int _currentIndex = 0;
  String _title = 'Home';

  final List<Widget> _children = [
    HomeAccountScreen(),
    BenefitScreen(),
    FundLoanScreen(),
    CheckInScreen(),
    EmployeeScreen(),
  ];

  //create condition when switch tab
  void onTabTab(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          _title = 'Home';
          break;
        case 1:
          _title = 'Benefit';
          break;
        case 2:
          _title = 'Fund Loan';
          break;
        case 3:
          _title = 'Check-In';
          break;
        case 4:
          _title = 'My Profile';
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text('$_title'),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                currentAccountPicture: GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/trex.png'),
                    backgroundColor: Colors.white70,
                  ),
                ),
                accountName: Text('$_employeeName'),
                accountEmail: Text('$_employeeEmpID'),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.new_releases),
                title: Text('News'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/news');
                },
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Employee Data'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.branding_watermark),
                title: Text('Benefit'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.data_usage),
                title: Text('Fund'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.timelapse),
                title: Text('Check-in'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.pin_drop),
                title: Text('Service Area'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/serviceMap');
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera & Upload'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/camera_upload');
                },
              ),
              Divider(
                color: Colors.green[200],
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sign Out'),
                onTap: () {
                  _signOut();
                },
              ),
              ListTile(
                leading: Icon(Icons.cancel),
                title: Text('Deactivate Account'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/cancelaccount');
                },
              ),
            ],
          ),
        ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          onTabTab(value);
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.enhanced_encryption),
            title: Text('Benefit'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            title: Text('Fund'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            title: Text('Check-in'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Me'),
          )
        ],
      ),
    );
  }
}
