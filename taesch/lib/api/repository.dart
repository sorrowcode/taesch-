import 'package:flutter/cupertino.dart';
import 'package:taesch/api/map_api_logic/geolocation_tools.dart';
import 'package:taesch/model/map_spot.dart';
import 'package:taesch/model/shopping_list_item.dart';
import 'package:taesch/utils/my_tools.dart';

class Repository {
  bool isDarkModeEnabled = false;
  List<ShoppingListItem> shoppingListItems = [];
  ValueNotifier<int> shoppingListSize = ValueNotifier(0);
  List<MapSpot> shopsCache = [];

  GeolocationTools geolocationTools = GeolocationTools();
  MyTools tools = MyTools();

  static final Repository _singleton = Repository._internal();

  factory Repository() {
    return _singleton;
  }

  Repository._internal();
}
