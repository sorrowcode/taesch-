import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:taesch/api/actions/osm_actions.dart';
import 'package:taesch/api/map_api_logic/overpass_query_indexes.dart';
import 'package:taesch/model/map_spot.dart';
import 'package:taesch/model/shop.dart';

class OSM implements OSMActions {

  late final String _apiUrl;

  @override
  void init() {
    _apiUrl = 'http://overpass-api.de//api/interpreter?';
  }

  @override
  Future<List<Shop>> getNearShops(int searchRadius, Position position) async {
    List<Shop> shops = [];
    Response response = await get(
        Uri.parse("$_apiUrl data=[out:json][timeout:50];"
            "(node[\"shop\"=\"supermarket\"](around:$searchRadius,${position.latitude},${position.longitude})"
            ";);out;"))
        .timeout(const Duration(seconds: 4));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBodyRaw = jsonDecode(utf8.decode(response.body.codeUnits));
      List<dynamic> nodes = responseBodyRaw["elements"];
      List<Shop> shops = [];
      for (dynamic node in nodes) {
        var test = node as Map<String, dynamic>;
        var data = test["tags"];
        var shopData = data as Map<String, dynamic>;
        Shop shop = Shop(spot: MapSpot(
            name: shopData[OverpassQueryIndexes.name.identifier],
            lat: data[OverpassQueryIndexes.latitude.identifier] == null ? 0 : double.parse(data[OverpassQueryIndexes.latitude.identifier].toString()),
            long: data[OverpassQueryIndexes.longitude.identifier] == null ? 0 : double.parse(data[OverpassQueryIndexes.longitude.identifier].toString()),
            street: shopData[OverpassQueryIndexes.street.identifier] ?? "noinfo",
            houseNumber: shopData[OverpassQueryIndexes.houseNumber.identifier] ?? "noinfo",
            postcode: shopData[OverpassQueryIndexes.postcode.identifier] == null ? 0 : int.parse(shopData[OverpassQueryIndexes.postcode.identifier].toString())
        ));
        shops.add(shop);
      }
    }

    return shops;
  }
}
