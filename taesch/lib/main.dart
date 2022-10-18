import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'app.dart';

/// entry point
void main() {
  runApp(const App());
  Future<Position> position = Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}
