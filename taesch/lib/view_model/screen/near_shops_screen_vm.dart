import 'package:taesch/api/map_api_logic/api_querier.dart';
import 'package:taesch/api/repository.dart';
import 'package:taesch/view/screen/near_shops_screen.dart';

/// vm for [NearShopsScreen]
class NearShopsScreenVM {
  final APIQuerier _apiQuerier = APIQuerier();
  var repository = Repository();

  void getShops() {
    _apiQuerier.makeHTTPRequest();
    repository.shopsCache = _apiQuerier.extractJSONData();
  }
}
