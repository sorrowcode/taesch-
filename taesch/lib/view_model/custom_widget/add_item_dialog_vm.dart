import 'package:taesch/api/repository.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/model/product.dart';
import 'package:taesch/model/tag.dart';

class AddItemDialogVM {
  final String title = 'Add Item to Shopping List';
  final String textFormHint = 'Enter Item';
  final String tagFormHint = 'tags (comma separated)';
  Product? temp;
  List<Tag> tags = [];
  var repository = Repository();

  ErrorCase? validateShoppingListItem(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorCase.emptyField;
    } else {
      temp = Product(name: value, imageUrl: '');
    }
    return null;
  }
  validateTags(String? value) {
    temp?.tags = tags;
    return null;
  }

  bool tagValidator(String value) {
    if (value.endsWith(' ')||value.endsWith(',')) {
      value = value.substring(0,value.length-1);//cutts the last character
      tags.insert(0, Tag(name: value));
      return true;
    }
    return false;
  }
}
