import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taesch/model/shop.dart';
import 'package:flutter/cupertino.dart';
import 'package:taesch/api/map_api_logic/geolocation_tools.dart';
import 'package:taesch/api/map_api_logic/querying_tools.dart';
import 'package:taesch/model/shopping_list_item.dart';
import 'package:taesch/utils/my_tools.dart';


class Repository {
  bool isDarkModeEnabled = false;
  final List<ShoppingListItem> _shoppingListItems = [];
  ValueNotifier<int> shoppingListSize = ValueNotifier(0);
  List<Shop> shopsCache = [];
  ValueNotifier<int> shopsCacheSize = ValueNotifier(0);


  Position userPosition = const Position(
      latitude: 49.1427,
      longitude: 9.2109,
      timestamp: null,
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0
  );//LatLng(49.1427, 9.2109);

  late GeolocationTools geolocationTools;// = GeolocationTools(this);
  MyTools tools = MyTools();
  OSMQueries queries = OSMQueries();

  static final Repository _singleton = Repository._internal();

  factory Repository() {
    return _singleton;
  }

  Repository._internal(){
    geolocationTools = GeolocationTools(this);
  }

  List<ShoppingListItem> get shoppingListItems => _shoppingListItems;

  void fillUpCache(List<Shop> shops) {
    shopsCache = []; // reset
    for (Shop shop in shops) {
      shopsCache.add(shop);
    }
    shopsCacheSize.value = shopsCache.length;
  }

/* todo: delete
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
    */
}
