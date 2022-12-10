import 'dart:collection';

import 'package:taesch/api/repositories/repository_type.dart';
import 'package:taesch/api/repositories/sql_repository.dart';
import 'package:taesch/api/repository_holder.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/model/product.dart';
import 'package:taesch/model/tag.dart';

class AddItemDialogVM {
  final String title = 'Add Item to Shopping List';
  final String textFormHint = 'Enter Item';
  final String tagFormHint = 'tags (comma separated)';
  Product? temp;
  HashSet<Tag> tags = HashSet(
      equals: (e, m) => e.name == m.name, hashCode: (e) => e.name.hashCode);
  SQLRepository sqlRepository = (RepositoryHolder().getRepositoryByType(RepositoryType.sql) as SQLRepository);

  ErrorCase? validateShoppingListItem(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorCase.emptyField;
    } else {
      temp = Product(name: value, imageUrl: '');
    }
    return null;
  }

  validateTags(String? value) {
    temp?.tags = tags.toList();
    if (value == null || value == '') return null;
    var match =
        RegExp(r'[a-zA-Z0-9äöüßÄÖÜ]+', unicode: true).stringMatch(value);
    match != null ? temp?.tags.add(Tag(name: match)) : null;
    return null;
  }

  bool tagValidator(String value) {
    var match = RegExp(r'[a-zA-Z0-9äöüßÄÖÜ]+[,\s]').stringMatch(value);
    if (match != null) {
      match = match.substring(0, match.length - 1); //cutts the last character
      tags.add(Tag(name: match));
      return true;
    }
    return false;
  }
}
