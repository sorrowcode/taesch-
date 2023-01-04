import 'package:taesch/model/discount.dart';
import 'package:taesch/model/map_spot.dart';

class Shop {
  final int id;
  late MapSpot _spot;
  Discount discount = Discount();

  Shop({required this.id, required MapSpot spot}) {
    _spot = spot;
  }

  String get name => _spot.name;

  String get address => _spot.street;

  String get houseNumber => _spot.houseNumber;

  MapSpot get mapSpot => _spot;
}
