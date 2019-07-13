import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
//import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';


/// Here we will have our [GoogleMaps] where the marker on current location would
/// be shown and when the new complaint button is pressed, we will send the current
/// location URL to next screen, where we will take a photo and will upload to the
/// server after encoding to [base64] type String


class CurrentLocation extends StatefulWidget {
  @override
  _CurrentLocationState createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {


  var currentLocation;
  GoogleMapController mapController;
  bool loaded = false;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  getmyLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    final MarkerId markerId = MarkerId("location");
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(position.latitude, position.longitude),
    );
    setState(() {
      loaded = true;
      currentLocation = LatLng(position.latitude, position.longitude);
      markers[markerId] = marker;
    });

    print(currentLocation);
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getmyLocation();
  }



  @override
  Widget build(BuildContext context) {
    print(loaded);
    return Scaffold(
        appBar: AppBar(
          title: Text('Current location'),
          backgroundColor: Colors.teal,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height - 80.0,
          width: double.infinity,
          child: loaded ?
          GoogleMap(
            onMapCreated: _onMapCreated,

            initialCameraPosition: CameraPosition(
                tilt: 80.0,
                bearing: 60.0,
                target: currentLocation,
                zoom: 17.0
            ),
            markers: Set<Marker>.of(markers.values),
          ):
          Center(
            child: CircularProgressIndicator(backgroundColor: Colors.teal,),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          onPressed: (){
            Navigator.of(context).pushNamed("/new_complaint");
          },
          child: Icon(
            Icons.mode_edit,
            size: 20.0,
          ),
        ),
      );
  }
  void _onMapCreated(controller){
    setState(() {
      mapController = controller;
    });
  }

}
