import 'package:flutter/cupertino.dart';
import 'package:taesch/api/repository.dart';
import 'package:taesch/view/screen/shopping_list_screen.dart';

/// vm for [ShoppingListScreen]
class ShoppingListScreenVM {
  var repository = Repository();

  Widget buildBody(BuildContext ctxt, int index, var widget) {
    return Text(widget
        ._vm.repository.shoppingListItems[index].tags);
  }
}
