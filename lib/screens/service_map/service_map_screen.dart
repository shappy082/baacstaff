import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ServiceMapScreen extends StatefulWidget {
  ServiceMapScreen({Key key}) : super(key: key);

  @override
  _ServiceMapScreenState createState() => _ServiceMapScreenState();
}

class _ServiceMapScreenState extends State<ServiceMapScreen> {
  // create position
  static const LatLng centerMap = const LatLng(13.840986, 100.5775362);

  // creat obj for handle google map
  GoogleMapController mapController;

  // initial state for map
  void _onMapCreate(GoogleMapController controller) {
    mapController = controller;
  }

  // create map marker
  // Set<Marker> myMark() {
  //   return <Marker>[
  //     Marker(
  //       markerId: MarkerId('Counter'),
  //       position: LatLng(13.842808, 100.577811),
  //     ),
  //     Marker(
  //       markerId: MarkerId('IT building'),
  //       position: LatLng(13.840980, 100.578460),
  //     )
  //   ].toSet();
  // }

  // create map markers set
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{
    MarkerId('baac-01'): Marker(
      markerId: MarkerId('baac-01'),
      position: LatLng(13.842808, 100.577811),
      infoWindow: InfoWindow(
        title: 'baac-01',
        snippet: 'test marker 1',
      ),
      onTap: () {
        print('test marker 1');
      },
    ),
    MarkerId('baac-02'): Marker(
      markerId: MarkerId('baac-02'),
      position: LatLng(13.840980, 100.578460),
      infoWindow: InfoWindow(
        title: 'baac-02',
        snippet: 'test marker 2',
      ),
      onTap: () {
        print('test marker 2');
      },
    ),
  };

  //create map
  Widget myMap() {
    return GoogleMap(
      onMapCreated: _onMapCreate,
      initialCameraPosition: CameraPosition(
        target: centerMap,
        zoom: 15.0,
      ),
      mapType: MapType.normal,
      myLocationEnabled: mounted,
      compassEnabled: true,
      markers: Set<Marker>.of(markers.values),
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
