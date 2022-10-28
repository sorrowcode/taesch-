import 'package:taesch/api/map_api_logic/api_querier.dart';
import 'package:taesch/model/map_spot.dart';
import 'package:taesch/view/screen/near_shops_screen.dart';

/// vm for [NearShopsScreen]
class NearShopsScreenVM {
  final APIQuerier _apiQuerier = APIQuerier();
  var shops = <MapSpot>[];

  void getShops() {
    _apiQuerier.makeHTTPRequest();
    shops = _apiQuerier.extractJSONData();
  }
}
