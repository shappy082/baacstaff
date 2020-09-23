import 'package:baacstaff/models/timeDetail_model.dart';
import 'package:baacstaff/services/rest_api.dart';
import 'package:flutter/material.dart';

class CheckInScreen extends StatefulWidget {
  CheckInScreen({Key key}) : super(key: key);

  @override
  _CheckInScreenState createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: CallAPI().getTimeDetail(),
          builder: (BuildContext context,
              AsyncSnapshot<List<TimeDetailModel>> snapshot) {
            if (snapshot.hasError) {
              //error
              return Center(
                child: Text('Loading Error...'),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
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
    );
  }

  // create listview for timeDetail
  Widget _listViewTimeDetail(List<TimeDetailModel> timeDetail) {
    return ListView.builder(
      itemCount: timeDetail.length,
      itemBuilder: (context, index) {
        TimeDetailModel timeDetailModel = timeDetail[index];
        return Container(
          child: Container(
            child: Column(
              children: [
                Text(timeDetailModel.type),
                Text('Date: ' + timeDetailModel.date),
                Text('Time: ' + timeDetailModel.time),
              ],
            ),
          ),
        );
      },
    );
  }
}
