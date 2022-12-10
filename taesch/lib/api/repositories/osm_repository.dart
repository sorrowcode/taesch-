import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taesch/api/actions/osm_actions.dart';
import 'package:taesch/api/repositories/repository_type.dart';
import 'package:taesch/api/repositories/repo.dart';
import 'package:taesch/model/shop.dart';

class OSMRepository extends Repo {

  List<Shop> cache = [];

  Position userPosition = const Position(latitude: 49.1427,
      longitude: 9.2109,
      timestamp: null,
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0);

  OSMRepository({required OSMActions super.actions}) {
    type = RepositoryType.osm;
    startGeoTimer();
  }

  OSMActions get osmActions => actions as OSMActions;

  void startGeoTimer() {
    Timer.periodic(const Duration(minutes: 5), (timer) async {
      userPosition = await osmActions.getCurrentPosition();
    });
  }
}
