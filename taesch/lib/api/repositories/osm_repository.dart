import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taesch/api/actions/osm_actions.dart';
import 'package:taesch/api/repositories/repository.dart';
import 'package:taesch/api/repositories/repository_type.dart';
import 'package:taesch/model/shop.dart';

class OSMRepository extends Repo {
  List<Shop> cache = [];

  Position userPosition = const Position(
      latitude: 49.1427,
      longitude: 9.2109,
      timestamp: null,
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0);

  static const radiusPrefKey = 'radius';
  int _searchRadius = 5000; //m
  late final SharedPreferences _prefs;

  OSMRepository({required OSMActions super.actions}) {
    type = RepositoryType.osm;
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
      _searchRadius = _prefs.getInt(radiusPrefKey) ?? 5000;
    });
  }

  int get searchRadius => _searchRadius;
  set searchRadius(int radius) {
    _searchRadius = radius;
    _prefs.setInt(radiusPrefKey, radius);
  }

  OSMActions get osmActions => actions as OSMActions;

  void startGeoTimer() {
    Timer.periodic(const Duration(minutes: 5), (timer) async {
      userPosition = await osmActions.getCurrentPosition();
    });
  }
}
