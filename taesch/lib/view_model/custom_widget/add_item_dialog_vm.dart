import 'package:taesch/api/repository.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/model/shopping_list_item.dart';
import 'package:taesch/model/tag.dart';

class AddItemDialogVM {
  final String title = 'Add Item to Shopping List';
  final String textFormHint = 'Enter Item';
  late ShoppingListItem temp;
  List<Tag> tags = [];
  var repository = Repository();

  ErrorCase? validateShoppingListItem(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorCase.emptyField;
    } else {
      temp = ShoppingListItem(title: value, image: '');
    }
    return null;
  }
  validateTags(String? value) {
    if (value == null || value.isEmpty) {
      return;
    } else {
      temp.tags.addAll(value.split(', ').map((e) => Tag(tagName: e)));
    }
    return null;
  }
}
