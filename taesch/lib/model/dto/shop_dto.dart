import 'dart:collection';

import 'package:taesch/model/map_spot.dart';
import 'package:taesch/model/shop.dart';

class ShopDTO {
  late Shop shop;

  ShopDTO({required this.shop});

  ShopDTO.fromJson(Map<String, Object> json) {
    shop = Shop(
        id: json["id"] as int,
        spot: MapSpot(
          name: json["name"] as String,
          latitude: json["latitude"] as double,
          longitude: json["longitude"] as double,
          street: json["street"] as String,
          postcode: json["postcode"] as int,
          houseNumber: json["houseNumber"] as String,
        ));
  }

  Map<String, Object> toJson() {
    HashMap<String, Object> json = HashMap();
    json.putIfAbsent("id", () => shop.id);
    json.putIfAbsent("name", () => shop.mapSpot.name);
    json.putIfAbsent("latitude", () => shop.mapSpot.latitude);
    json.putIfAbsent("longitude", () => shop.mapSpot.longitude);
    json.putIfAbsent("street", () => shop.mapSpot.street);
    json.putIfAbsent("postcode", () => shop.mapSpot.postcode);
    json.putIfAbsent("houseNumber", () => shop.mapSpot.houseNumber);
    return json;
  }
}
