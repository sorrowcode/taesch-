import 'package:taesch/api/repositories/osm_repository.dart';
import 'package:taesch/api/repositories/repository_type.dart';
import 'package:taesch/api/repository_holder.dart';
import 'package:taesch/model/shop.dart';
import 'package:taesch/view/screen/near_shops_screen.dart';

/// vm for [NearShopsScreen]
class NearShopsScreenVM {
  var isMap = false;
  late Shop selectedShop;
  List<Shop> shops = [
    /*Shop(spot: MapSpot(name: "test", lat: 49.0, long: 9.2, street: "Teststraße", houseNumber: "1", postcode: 11111))*/
  ];
  OSMRepository osmRepository = (RepositoryHolder()
      .getRepositoryByType(RepositoryType.osm) as OSMRepository);
}
