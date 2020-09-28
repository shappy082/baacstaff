import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ServiceMapScreen extends StatefulWidget {
  ServiceMapScreen({Key key}) : super(key: key);

  @override
  _ServiceMapScreenState createState() => _ServiceMapScreenState();
}

class _ServiceMapScreenState extends State<ServiceMapScreen> {
  //create position
  static const LatLng centerMap = const LatLng(13.840986, 100.5775362);

  //create marker
  Set<Marker> myMark() {
    return <Marker>[
      Marker(
        markerId: MarkerId('Counter'),
        position: LatLng(13.842808, 100.577811),
      ),
      Marker(
        markerId: MarkerId('IT building'),
        position: LatLng(13.840980, 100.578460),
      )
    ].toSet();
  }

  //create map
  Widget myMap() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: centerMap,
        zoom: 16,
      ),
      mapType: MapType.normal,
      myLocationEnabled: mounted,
      compassEnabled: true,
      markers: myMark(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Map'),
      ),
      body: myMap(),
    );
  }
}
