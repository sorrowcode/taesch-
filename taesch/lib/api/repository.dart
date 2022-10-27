import 'package:taesch/model/shopping_list_item.dart';

class Repository {
  bool isDarkModeEnabled = false;
  List<ShoppingListItem> shoppingListItems = [];

  static final Repository _singleton = Repository._internal();

  factory Repository() {
    return _singleton;
  }

  Repository._internal();
}
