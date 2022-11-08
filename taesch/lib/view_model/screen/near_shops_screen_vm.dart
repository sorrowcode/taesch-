import 'package:taesch/api/map_api_logic/api_querier.dart';
import 'package:taesch/api/repository.dart';
import 'package:taesch/model/map_spot.dart';
import 'package:taesch/view/screen/near_shops_screen.dart';

import '../../model/shop.dart';

/// vm for [NearShopsScreen]
class NearShopsScreenVM {
  final APIQuerier _apiQuerier = APIQuerier();
  var repository = Repository();

  void loadShops() {
    _apiQuerier.makeHTTPRequest();
    var extractedData = _apiQuerier.extractJSONData();
    List<Shop> shops = [];
    for (MapSpot spot in extractedData) {
      shops.add(Shop(spot: spot));
    }
    repository.fillUpShopCache(shops);
    repository.fillUpMapSpotCache(extractedData);
  }
}
