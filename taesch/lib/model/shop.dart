import 'package:geolocator/geolocator.dart';
import 'package:taesch/model/discount.dart';
import 'package:taesch/model/map_spot.dart';

class Shop {
  late MapSpot _spot;
  Discount discount = Discount();

  Shop({required MapSpot spot}) {
    _spot = spot;
  }

  String get name => _spot.name;

  String get address => _spot.address;

}
