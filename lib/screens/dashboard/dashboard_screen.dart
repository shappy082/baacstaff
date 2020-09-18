import 'package:baacstaff/screens/bottom_nav/benefit/benefit_screen.dart';
import 'package:baacstaff/screens/bottom_nav/checkin/checkin_screen.dart';
import 'package:baacstaff/screens/bottom_nav/employee/employee_screen.dart';
import 'package:baacstaff/screens/bottom_nav/fundLoan/fund_loan_screen.dart';
import 'package:baacstaff/screens/bottom_nav/home/home_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
                    backgroundColor: Colors.white10,
                  ),
                ),
                accountName: Text('Samit'),
                accountEmail: Text('samit@gmail.com'),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.new_releases),
                title: Text('ข้อมูลข่าวสาร ธกส.'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/baacnews');
                },
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('ข้อมูลพนักงาน '),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.branding_watermark),
                title: Text('สวัสดิการ'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.data_usage),
                title: Text('กองทุนกู้ยืมเพื่อสวัสดิการ'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.timelapse),
                title: Text('ลงเวลาทำงาน'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(
                color: Colors.green[200],
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('ออกจากระบบ'),
                onTap: () {
                  // เคลียร์ค่าใน sharedPreferences
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/lockscreen');
                },
              ),
              ListTile(
                leading: Icon(Icons.cancel),
                title: Text('ยกเลิกการลงทะเบียน'),
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
            title: Text('City'),
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