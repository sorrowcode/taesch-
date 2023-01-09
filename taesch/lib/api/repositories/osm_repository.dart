import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:taesch/api/actions/osm_actions.dart';
import 'package:taesch/api/repositories/repository.dart';
import 'package:taesch/api/repositories/repository_type.dart';
import 'package:taesch/model/shop.dart';

class OSMRepository extends Repo {
  List<Shop> cache = [];

  bool geolocatorServicesEnabled = true;
  bool geolocatorPermissionIsSet = false;
  bool permamnentlyDenied = false;

  Position userPosition = const Position(
      latitude: 49.1427,
      longitude: 9.2109,
      timestamp: null,
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0);

  bool geolocationServicesEnabled(){
    return geolocatorServicesEnabled;
  }

  bool geoLocationPermissionGranted(){
    return geolocatorPermissionIsSet;
  }

  bool geoLocationPermissionIsPermanentlyDenied(){
    return permamnentlyDenied;
  }

  void denyGeoLocationPermission(){
    geolocatorPermissionIsSet = false;
  }

  OSMRepository({required OSMActions super.actions}) {
    type = RepositoryType.osm;
  }

  OSMActions get osmActions => actions as OSMActions;

  void startGeoTimer() {
    Timer.periodic(const Duration(minutes: 5), (timer) async {
      userPosition = await osmActions.getCurrentPosition();
    });
  }
}
