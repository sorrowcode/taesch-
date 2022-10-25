import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taesch/geo_tester.dart';
//import 'package:flutter_geo_guesser/api/overpass_api.dart'

import 'app.dart';

/// entry point
void main() {
  runApp(const App());
  //Future<LocationPermission> permission = Geolocator.requestPermission();
  //Future<Position> position = Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);//sdks 26 - 33

  GeoTester geoTester = GeoTester();
  geoTester.makeHTTPRequest();
}
