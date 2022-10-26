import 'package:taesch/model/screen_state.dart';
import 'package:taesch/model/error.dart';
import 'package:taesch/pages/model/api/storage_shop_items.dart';
import 'package:taesch/pages/model/shoppingitem.dart';
class HomePageVM {
  ScreenState screenState = ScreenState.shoppingList;
  static const String shoppingListItemText = '';


  Error? validateShoppingListItem(String? value){
    if(value == null || value.isEmpty){
      return Error.emptyField;
    }else{
      ShoppingItem item = ShoppingItem(value, "");
      StorageShopItems.create().then((value) => (){
        value.insert(item);
      });
    }
    return null;
  }
}
