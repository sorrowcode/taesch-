import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:taesch/api/actions/osm_actions.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/log_message.dart';
import 'package:taesch/model/map_spot.dart';
import 'package:taesch/model/shop.dart';

import 'overpass_query_index.dart';

class OSM implements OSMActions {
  LoggerWrapper logger = LoggerWrapper();
  late final String _apiUrl;

  bool _geolocatorServicesEnabled = true;
  bool _geolocatorPermissionIsSet = false;
  bool _permamnentlyDenied = false;

  @override
  void init() {
    _apiUrl = 'http://overpass-api.de//api/interpreter?';
  }

  @override
  Future<List<Shop>> getNearShops(int searchRadius, Position position) async {
    List<Shop> shops = [];
    Response response = await get(Uri.parse(
        "${_apiUrl}data=[out:json][timeout:50];"
        "(node[\"shop\"=\"supermarket\"](around:$searchRadius,${position.latitude},${position.longitude})"
        ";);out;"));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBodyRaw =
          jsonDecode(utf8.decode(response.body.codeUnits));
      List<dynamic> nodes = responseBodyRaw["elements"];
      for (dynamic node in nodes) {
        var test = node as Map<String, dynamic>;
        var data = test["tags"];
        var id = int.parse(test[OverpassQueryIndex.id.identifier].toString());
        var shopData = data as Map<String, dynamic>;
        Shop shop = Shop(
            id: id,
            //shopData[OverpassQueryIndex.id.identifier] == null ? 0 : int.parse(shopData[OverpassQueryIndex.id.identifier].toString()),
            spot: MapSpot(
                name: shopData[OverpassQueryIndex.name.identifier],
                longitude: test[OverpassQueryIndex.latitude.identifier] == null
                    ? 0
                    : double.parse(test[OverpassQueryIndex.latitude.identifier]
                        .toString()),
                latitude: test[OverpassQueryIndex.longitude.identifier] == null
                    ? 0
                    : double.parse(test[OverpassQueryIndex.longitude.identifier]
                        .toString()),
                street:
                    shopData[OverpassQueryIndex.street.identifier] ?? "noinfo",
                houseNumber:
                    shopData[OverpassQueryIndex.houseNumber.identifier] ??
                        "noinfo",
                postcode: shopData[OverpassQueryIndex.postcode.identifier] ==
                        null
                    ? 0
                    : int.parse(shopData[OverpassQueryIndex.postcode.identifier]
                        .toString())));
        shops.add(shop);
      }
    }

    return shops;
  }

  @override
  Future<Position> getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position;
  }

  @override
  Future<void> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    _geolocatorServicesEnabled = true;
    if (!serviceEnabled) {
      logger.log(
          level: LogLevel.info,
          logMessage: LogMessage(
              message: "Location services are disabled. Please enable the services.")// <-- maybe show a pop-up
      );
      _geolocatorServicesEnabled = false;
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission(); // <-- check again
      if (permission != LocationPermission.denied && permission != LocationPermission.deniedForever) {
        logger.log(
            level: LogLevel.info,
            logMessage: LogMessage(
                message: "Geolocator is permitted.")
        );
        _geolocatorPermissionIsSet = true;
        _permamnentlyDenied = false;
        _geolocatorServicesEnabled = true;
        return;

      } else {
        logger.log(
            level: LogLevel.info,
            logMessage: LogMessage(
                message: "Location permissions are denied.")
        );
        _geolocatorPermissionIsSet = false;
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      logger.log(
          level: LogLevel.info,
          logMessage: LogMessage(
              message: "Location permissions are permanently denied, we cannot request permissions.")
      );
      _geolocatorPermissionIsSet = false;
      _permamnentlyDenied = true;
      return;
    }

    logger.log(
        level: LogLevel.info,
        logMessage: LogMessage(
            message: "Geolocator is permitted.")
    );
    _geolocatorPermissionIsSet = true;
    _permamnentlyDenied = false;
    return;
  }

  @override
  bool geolocationServicesEnabled(){
    return _geolocatorServicesEnabled;
  }

  @override
  bool geoLocationPermissionGranted(){
    return _geolocatorPermissionIsSet;
  }

  @override
  bool geoLocationPermissionIsPermanentlyDenied(){
    return _permamnentlyDenied;
  }

  @override
  void denyGeoLocationPermission(){
    _geolocatorPermissionIsSet = false;
  }
}
