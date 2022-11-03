import 'package:flutter/cupertino.dart';
import 'package:taesch/model/map_spot.dart';
import 'package:taesch/model/shopping_list_item.dart';

class Repository {
  bool isDarkModeEnabled = false;
  List<ShoppingListItem> shoppingListItems = [];
  ValueNotifier<int> shoppingListSize = ValueNotifier(0);
  List<MapSpot> shopsCache = [];

  static final Repository _singleton = Repository._internal();

  factory Repository() {
    return _singleton;
  }

  Repository._internal();
}
