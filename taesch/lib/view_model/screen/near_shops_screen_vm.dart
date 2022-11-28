import 'package:taesch/api/map_api_logic/api_querier.dart';
import 'package:taesch/api/repository.dart';
import 'package:taesch/model/map_spot.dart';
import 'package:taesch/model/shop.dart';
import 'package:taesch/view/screen/near_shops_screen.dart';

/// vm for [NearShopsScreen]
class NearShopsScreenVM {
  final APIQuerier _apiQuerier = APIQuerier();
  var repository = Repository();
  var isMap = false;

  void loadShops() {
    _apiQuerier.makeHTTPRequest();
    var extractedData = _apiQuerier.extractJSONData();
    List<Shop> shops = [];
    for (MapSpot spot in extractedData) {
      shops.add(Shop(spot: spot));
    }

    repository.fillUpCache(shops);
    //repository.fillUpShopCache(shops); todo: delete
    //repository.fillUpMapSpotCache(extractedData);
  }
}
