import 'package:taesch/api/storage_shop_items.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/model/screen_state.dart';
import 'package:taesch/model/shopping_list_item.dart';

class HomePageVM {
  ScreenState screenState = ScreenState.shoppingList;
  static const String shoppingListItemText = '';

  ErrorCase? validateShoppingListItem(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorCase.emptyField;
    } else {
      ShoppingListItem item = ShoppingListItem(value, "");
      StorageShopItems.create().then((value) => () {
            value.insert(item);
          });
    }
    return null;
  }
}
