import 'dart:collection';

import 'package:taesch/model/keys/map_spot_keys.dart';
import 'package:taesch/model/map_spot.dart';

class Shop {
  late final int id;
  late MapSpot spot;

  //Discount discount = Discount();

  Shop({required this.id, required this.spot}) {
    spot = spot;
  }

  Shop.fromMap(HashMap<String, dynamic> map) {
    id = int.parse(map["id"].toString());
    spot = MapSpot(
        name: map[MapSpotKeys.name.text()].toString(),
        latitude: double.parse(map[MapSpotKeys.latitude.text()].toString()),
        longitude: double.parse(map[MapSpotKeys.longitude.text()].toString()),
        street: map[MapSpotKeys.street].toString(),
        houseNumber: map[MapSpotKeys.houseNumber.text()].toString(),
        postcode: int.parse(map[MapSpotKeys.postcode.text()].toString()));
  }
}
