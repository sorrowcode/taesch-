import 'package:flutter_map/flutter_map.dart';
import 'package:taesch/api/repositories/osm_repository.dart';
import 'package:taesch/api/repositories/repository_type.dart';
import 'package:taesch/api/repository_holder.dart';
import 'package:taesch/model/map_spot.dart';
import 'package:taesch/model/shop.dart';

class ShopsMapScreenVM {
  Shop? shop;
  OSMRepository osmRepository = (RepositoryHolder()
      .getRepositoryByType(RepositoryType.osm) as OSMRepository);
  List<Marker> shopsMarker = [];
  int idCounter = 1;
  int lastID = 0;
  Shop lastShop = Shop(spot: MapSpot(
    name: "dummy",
    long: 0,
    lat: 0,
    street: "dummy",
    houseNumber: "0",
    postcode: 0
  ));
}
