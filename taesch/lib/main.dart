import 'package:flutter/material.dart';

import 'app.dart';

/// entry point
void main() {
  //Future<LocationPermission> permission = Geolocator.requestPermission();
  //Future<Position> position = Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);//sdks 26 - 33

  //APIQuerier apiQuerier = APIQuerier();
  //apiQuerier.makeHTTPRequest();
  runApp(App());
}
