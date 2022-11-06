import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taesch/api/map_api_logic/geolocation_tools.dart';

import 'app.dart';

/// entry point
void main() {
  //Future<LocationPermission> permission = Geolocator.requestPermission();
  //Future<Position> position = Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);//sdks 26 - 33

  //Future<bool> permission = GeolocationTools.handleLocationPermission();

  //APIQuerier apiQuerier = APIQuerier();
  //apiQuerier.makeHTTPRequest();
  runApp(App());

  // the following can only be called after WidgetsFlutterBinding.ensureInitialized() has been called
  print("fetch Position");
  GeolocationTools.getCurrentPosition();
}
