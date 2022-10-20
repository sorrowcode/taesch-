import 'package:flutter/material.dart';
import 'package:taesch/app.dart';
import 'package:taesch/model/screen.dart';
import 'package:taesch/pages/view/near_shops_page.dart';
import 'package:taesch/pages/view/settings_page.dart';
import 'package:taesch/pages/view/shopping_list_page.dart';

/// vm for [App] view
class AppVM {
  Screen screenState = Screen.shoppingList;

  Widget getCurrentScreen() {
    switch (screenState) {
      case Screen.shoppingList:
        return const ShoppingListPage();
      case Screen.nearShops:
        return const NearShopsPage();
      case Screen.settings:
        return const SettingsPage();
    }
  }
}
