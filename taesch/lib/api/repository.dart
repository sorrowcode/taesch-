import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taesch/api/map_api_logic/geolocation_tools.dart';
import 'package:taesch/api/map_api_logic/querying_tools.dart';
import 'package:taesch/api/sql/sql_database.dart';
import 'package:taesch/model/shop.dart';
import 'package:taesch/utils/my_tools.dart';

class Repository {
  bool _isDarkModeEnabled = false;
  List<Shop> shopsCache = [];
  ValueNotifier<int> shopsCacheSize = ValueNotifier(0);
  SQLDatabase sqlDatabase = SQLDatabase();

  Position _userPosition = const Position(
      latitude: 49.1427,
      longitude: 9.2109,
      timestamp: null,
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0); //LatLng(49.1427, 9.2109);

  void setPosition(Position position) {
    _userPosition = position;
    queries.setCustomLocation(LatLng(position.latitude, position.longitude));
  }

  Position getUserPosition() {
    return _userPosition;
  }

  late GeolocationTools geolocationTools; // = GeolocationTools(this);
  MyTools tools = MyTools();
  OSMQueries queries = OSMQueries();

  static final Repository _singleton = Repository._internal();

  factory Repository() {
    return _singleton;
  }

  set isDarkModeEnabled(bool enabled) {
    _isDarkModeEnabled = enabled;
    SharedPreferences.getInstance()
        .then((prefs) => prefs.setBool('dark_mode_enabled', enabled));
  }

  bool get isDarkModeEnabled => _isDarkModeEnabled;

  Repository._internal() {
    geolocationTools = GeolocationTools(this);

    SharedPreferences.getInstance().then((prefs) => _isDarkModeEnabled =
        prefs.containsKey('dark_mode_enabled')
            ? prefs.getBool('dark_mode_enabled')!
            : false);
  }

  void fillUpCache(List<Shop> shops) {
    shopsCache = []; // reset
    for (Shop shop in shops) {
      shopsCache.add(shop);
    }
    shopsCacheSize.value = shopsCache.length;
  }
}
