import 'package:taesch/api/map_api_logic/api_querier.dart';
import 'package:taesch/api/repository.dart';
import 'package:taesch/model/map_spot.dart';
import 'package:taesch/model/shop.dart';
import 'package:taesch/view/screen/near_shops_screen.dart';

/// vm for [NearShopsScreen]
class NearShopsScreenVM {
  final APIQuerier _apiQuerier = APIQuerier();
  var repository = Repository();

  void loadShops() async{
    if (!repository.requestingQueryHTTP) {
      // executes several times, in case a request fails

      bool extractedDataEmpty = true;
      int repeatTimes = 4, count = 0;
      repository.requestingQueryHTTP = true;

      while (extractedDataEmpty && count<repeatTimes) {
        //print("request http");
        await _apiQuerier.makeHTTPRequest();
        //print("await finished");
        var extractedData = _apiQuerier.extractJSONData();

        if(extractedData.isNotEmpty) {
          extractedDataEmpty = false;
          List<Shop> shops = [];
          for (MapSpot spot in extractedData) {
            shops.add(Shop(spot: spot));
          }
          repository.fillUpCache(shops);
          //repository.fillUpShopCache(shops); todo: delete
          //repository.fillUpMapSpotCache(extractedData);
          repository.lastWorkingPosition = repository.getUserPosition();
        }else{
          repository.setPosition(repository.lastWorkingPosition);
        }
        count++;
      }

      repository.requestingQueryHTTP = false;
    }
  }
}
