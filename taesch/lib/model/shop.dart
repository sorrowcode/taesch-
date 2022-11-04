import 'package:taesch/model/map_spot.dart';

class Shop {
  late MapSpot _spot;

  Shop({required MapSpot spot}) {
    _spot = spot;
  }

  String get shopName => _spot.name;

  String get address => _spot.address;
}