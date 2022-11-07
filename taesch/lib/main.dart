import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taesch/api/map_api_logic/geolocation_tools.dart';
import 'package:taesch/utils/my_tools.dart';

import 'app.dart';

/// entry point
void main() {

  //Future<LocationPermission> permission = Geolocator.requestPermission();
  //Future<Position> position = Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);//sdks 26 - 33

  runApp(App());

  initialize();
}

void initialize(){
  GeolocationTools.startGeoTimer();
}
