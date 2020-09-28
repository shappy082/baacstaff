import 'package:baacstaff/models/timeDetail_model.dart';
import 'package:baacstaff/services/rest_api.dart';
import 'package:flutter/material.dart';

class CheckInScreen extends StatefulWidget {
  CheckInScreen({Key key}) : super(key: key);

  @override
  _CheckInScreenState createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  List<dynamic> _timeDetails = [];
  Future fetchTimeDetail() async {
    var response = await CallAPI().getTimeDetail();
    setState(() {
      _timeDetails = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _timeDetails != 0
          ? RefreshIndicator(
              onRefresh: fetchTimeDetail,
              child: Container(
                child: FutureBuilder(
                  future: CallAPI().getTimeDetail(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<TimeDetailModel>> snapshot) {
                    if (snapshot.hasError) {
                      //error
                      return Center(
                        child: Text('Loading Error... ${snapshot.error}'),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      //OK
                      List<TimeDetailModel> timeDetails = snapshot.data;
                      return _listViewTimeDetail(timeDetails);
                    } else {
                      //loading
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  // create listview for timeDetail
  Widget _listViewTimeDetail(List<TimeDetailModel> timedetail) {
    return ListView.builder(
        itemCount: timedetail.length,
        itemBuilder: (context, index) {
          TimeDetailModel timeDetailModel = timedetail[index];
          return Container(
            child: Card(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Column(
                          children: [
                            timeDetailModel.type == 'ลงเวลาเข้าทำงาน'
                                ? Icon(Icons.input)
                                : Icon(Icons.time_to_leave)
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(timeDetailModel.type),
                          Text('Date ' + timeDetailModel.date),
                          Text('Time ' + timeDetailModel.time)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
