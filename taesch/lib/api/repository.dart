import 'package:flutter/cupertino.dart';
import 'package:taesch/model/shop.dart';
import 'package:taesch/model/shopping_list_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  // late PersistStorage shopItemStorage;
  bool _isDarkModeEnabled = false;
  final List<ShoppingListItem> _shoppingListItems = [];
  ValueNotifier<int> shoppingListSize = ValueNotifier(0);
  List<Shop> shopsCache = [];
  ValueNotifier<int> shopsCacheSize = ValueNotifier(0);

  static final Repository _singleton = Repository._internal();

  factory Repository() {
    return _singleton;
  }

  set isDarkModeEnabled(bool enabled) {
    _isDarkModeEnabled = enabled;
    SharedPreferences.getInstance().then((prefs) => prefs.setBool('dark_mode_enabled', enabled));
  }
  bool get isDarkModeEnabled => _isDarkModeEnabled;

  Repository._internal(){
    SharedPreferences.getInstance().then((prefs) => _isDarkModeEnabled = prefs.containsKey('dark_mode_enabled')?prefs.getBool('dark_mode_enabled')!:false);
    // StorageShopItems.create().then((store) {StorageShopItems shopItemStorage = store;return store;});
        // .then((store) {
        //   shoppingListSize.addListener(() {store.replace(shoppingListItems);});
        // });
  }

  List<ShoppingListItem> get shoppingListItems => _shoppingListItems;
}
