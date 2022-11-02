import 'package:taesch/api/repository.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/model/shopping_list_item.dart';

class AddItemDialogVM {
  String title = 'Add Item to Shopping List';
  String textFormHint = 'Enter Item';
  late ShoppingListItem temp;
  var repository = Repository();

  ErrorCase? validateShoppingListItem(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorCase.emptyField;
    } else {
      temp = ShoppingListItem(value, "");
    }
    return null;
  }
}
