import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';
import 'package:taesch/model/shop.dart';
import 'package:taesch/model/shopping_list_item.dart';

import '../model/map_spot.dart';

class Repository {
  bool isDarkModeEnabled = false;
  final List<ShoppingListItem> _shoppingListItems = [];
  ValueNotifier<int> shoppingListSize = ValueNotifier(0);
  List<Shop> shopsCache = [];
  List<MapSpot> mapSpotsCache = []; // not all MapSpots might be Shops
  ValueNotifier<int> shopsCacheSize = ValueNotifier(0);

  LatLng userPosition = LatLng(49.1427,9.2109);

  static final Repository _singleton = Repository._internal();

  factory Repository() {
    return _singleton;
  }

  Repository._internal();

  List<ShoppingListItem> get shoppingListItems => _shoppingListItems;

  void fillUpShopCache(List<Shop> shops){
    shopsCache = []; // reset
    for (Shop shop in shops){
      shopsCache.add(shop);
    }
    shopsCacheSize.value = shopsCache.length;
  }

  void fillUpMapSpotCache(List<MapSpot> mapSpots){
    mapSpotsCache = []; // reset
    for (MapSpot spot in mapSpots){
      mapSpotsCache.add(spot);
    }
  }

}
