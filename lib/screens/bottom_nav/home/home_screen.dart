import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'package:baacstaff/models/news_model.dart';
import 'package:baacstaff/services/rest_api.dart';
import 'package:baacstaff/utils/utility.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:intl/intl.dart';

class HomeAccountScreen extends StatefulWidget {
  HomeAccountScreen({Key key}) : super(key: key);

  @override
  _HomeAccountScreenState createState() => _HomeAccountScreenState();
}

class _HomeAccountScreenState extends State<HomeAccountScreen> {
  final String _currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  final String _currentTime = DateFormat('HH:mm:ss').format(DateTime.now());

  Position _position;
  String _lat, _long;

  checkGPS() async {
    Position position;
    bool _isLocationServiceEnabled = await isLocationServiceEnabled();
    if (_isLocationServiceEnabled) {
      position =
          await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _lat = position.latitude.toString();
        _long = position.longitude.toString();
      });
      showDialog(
          context: context,
          builder: (BuildContext context) => SimpleDialog(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 15.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Date $_currentDate'),
                        Text('Time $_currentTime')
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.work),
                    title: Text('Check-in'),
                    onTap: () {
                      // Utility.getInstance().showAlertDialog(
                      //   context,
                      //   'Done',
                      //   'Check in time recorded.\nPosition $_lat, $_long',
                      // );

                      //Call api to check-in
                      Map<String, dynamic> body = {
                        "IMEI": "baac1234",
                        "latitude": "12",
                        "longtitude": "13",
                        "Type": "1"
                      };
                      checkInCheckOut(body);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.time_to_leave),
                    title: Text('Check-Out'),
                    onTap: () {
                      // Utility.getInstance().showAlertDialog(
                      //   context,
                      //   'Done',
                      //   'Check out time recorded.\nPosition\n$_lat, $_long',
                      // );

                      //Call api to check-out
                      Map<String, dynamic> body = {
                        "IMEI": "baac1234",
                        "latitude": "12",
                        "longtitude": "13",
                        "Type": "2"
                      };
                      checkInCheckOut(body);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    // mainAxisSize: MainAxisSize.max,

                    children: [
                      OutlineButton(
                        child: Icon(
                          Icons.close,
                          size: 20,
                        ),
                        color: Colors.red,
                        textColor: Colors.black,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ));
    } else {
      Utility.getInstance().showAlertDialog(
          context, "GPS is offline", "Please enable GPS service");
    }
    setState(() {
      _position = position;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checkGPS();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Container(
          width: double.infinity,
          height: 120.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.jpg'),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.redAccent,
                        child: CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage('assets/images/trex.png'),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Text(
                              'Shappy082',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          RaisedButton(
                            onPressed: () {
                              checkGPS();
                            },
                            child: Text(
                              'Check-in',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.blueAccent,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 15.0, bottom: 15.0),
          child: Text(
            'Latest News',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          child: FutureBuilder(
            future: CallAPI().getNews(),
            builder: (BuildContext context,
                AsyncSnapshot<List<NewsModel>> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error.toString()}'),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                List<NewsModel> news = snapshot.data;
                return _builderListView(news);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 15.0, bottom: 15.0),
          child: Text(
            'News',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          // height: MediaQuery.of(context).size.height * 0.25,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.25,
            child: FutureBuilder(
              future: CallAPI().getNews(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<NewsModel>> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error.toString()}'),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  List<NewsModel> news = snapshot.data;
                  return _listViewAllNews(news);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      ]),
    );
  }

  Widget _builderListView(List<NewsModel> news) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: news.length,
      itemBuilder: (context, index) {
        //load model
        NewsModel newsModels = news[index];
        return Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: InkWell(
            onTap: () =>
                url_launcher.launch('https://material.io/resources/icons'),
            child: Card(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(newsModels.imageurl),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        newsModels.topic,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        newsModels.detail,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _listViewAllNews(List<NewsModel> news) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: news.length,
      itemBuilder: (context, index) {
        //load model
        NewsModel newsModels = news[index];
        return Container(
          // width: MediaQuery.of(context).size.width * 0.6,
          child: ListTile(
            leading: Icon(Icons.new_releases),
            title: Text(
              newsModels.topic,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Utility.getInstance().showAlertDialog(
                  context, newsModels.topic, newsModels.detail);
            },
          ),
        );
      },
    );
  }

  checkInCheckOut(locationData) async {
    var isOnline = await Connectivity().checkConnectivity();
    if (isOnline == ConnectivityResult.none) {
      Utility.getInstance().showAlertDialog(context, "No Internet!",
          "Please connect to the internet and try again.");
    } else {
      var response = await CallAPI().checkInAndOut(locationData);
      var body = json.decode(response.body);
      print(body);
    }
  }
}
