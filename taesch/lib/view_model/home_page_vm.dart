import 'package:taesch/api/repository.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/model/screen_state.dart';
import 'package:taesch/model/shopping_list_item.dart';

class HomePageVM {
  var repository = Repository();
  ScreenState screenState = ScreenState.shoppingList;
  late ShoppingListItem temp;
  static const String shoppingListItemText = '';

  ErrorCase? validateShoppingListItem(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorCase.emptyField;
    } else {
      temp = ShoppingListItem(value, "");
    }
    return null;
  }
}
