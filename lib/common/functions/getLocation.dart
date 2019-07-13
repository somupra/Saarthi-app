import 'dart:async';
//import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

var locationurl;
//var currentLocationmap = LocationData;
//var location = new Location();

Future<String>getmyLocation() async {

  Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);


//  currentLocationmap = await location.getLocation();

  // For debugging
//  print(currentLocationmap);

  // set locationurl to some Location URL
//  locationurl = "www.google.com/maps/@"+currentLocationmap['longitude'].toStringAsFixed(6)+","+currentLocationmap.longitude.toStringAsFixed(6)+",15z";
  locationurl = "http://www.google.com/maps/@"+position.latitude.toStringAsFixed(6)+","+position.longitude.toStringAsFixed(6)+",20z";

  // for debugging
//  print(locationurl);

  return locationurl;
}