import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:taesch/api/implementation/osm.dart';
import 'package:taesch/api/implementation/overpass_query_index.dart';
import 'package:taesch/api/repositories/osm_repository.dart';
import 'package:taesch/api/repositories/repository_type.dart';
import 'package:taesch/api/repository_holder.dart';
import 'package:taesch/model/map_spot.dart';
import 'package:taesch/model/shop.dart';

void main() async {

  Response response = await get(
      Uri.parse("http://overpass-api.de//api/interpreter?data=[out:json][timeout:50];"
          "(node[\"shop\"=\"supermarket\"](around:2000,49.1427,9.2109)"
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
        name: shopData[OverpassQueryIndex.name.identifier],
        lat: data[OverpassQueryIndex.latitude.identifier] == null ? 0 : double.parse(data[OverpassQueryIndex.latitude.identifier].toString()),
        long: data[OverpassQueryIndex.longitude.identifier] == null ? 0 : double.parse(data[OverpassQueryIndex.longitude.identifier].toString()),
        street: shopData[OverpassQueryIndex.street.identifier] ?? "noinfo",
        houseNumber: shopData[OverpassQueryIndex.houseNumber.identifier] ?? "noinfo",
        postcode: shopData[OverpassQueryIndex.postcode.identifier] == null ? 0 : int.parse(shopData[OverpassQueryIndex.postcode.identifier].toString())
      ));
      shops.add(shop);
      print(shops.length);
    }

    //print(responseBodyRaw);
  }
}