import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:taesch/api/actions/osm_actions.dart';
import 'package:taesch/model/map_spot.dart';
import 'package:taesch/model/shop.dart';

import 'overpass_query_index.dart';

class OSM implements OSMActions {
  late final String _apiUrl;

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
            ";);out;"))
        .timeout(const Duration(seconds: 4));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBodyRaw =
          jsonDecode(utf8.decode(response.body.codeUnits));
      List<dynamic> nodes = responseBodyRaw["elements"];
      for (dynamic node in nodes) {
        var test = node as Map<String, dynamic>;
        var data = test["tags"];
        var shopData = data as Map<String, dynamic>;
        Shop shop = Shop(
            spot: MapSpot(
                name: shopData[OverpassQueryIndex.name.identifier],
                lat: test[OverpassQueryIndex.latitude.identifier] == null
                    ? 0
                    : double.parse(test[OverpassQueryIndex.latitude.identifier].toString()),
                long: test[OverpassQueryIndex.longitude.identifier] == null
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
  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // snackbar
      // print('Location services are disabled. Please enable the services'); // <- log
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      // print('Location permissions are denied');// <- log
      return false;
    }
    if (permission == LocationPermission.deniedForever) {
      // print('Location permissions are permanently denied, we cannot request permissions.'); // <- log
      return false;
    }
    // print("geolocator permitted."); // <- log
    return true;
  }
}
