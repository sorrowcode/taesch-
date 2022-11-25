import 'package:taesch/api/repository.dart';
import 'package:taesch/model/product.dart';
import 'package:taesch/view/screen/shopping_list_screen.dart';

/// vm for [ShoppingListScreen]
class ShoppingListScreenVM {
  List<Product> products;
  Repository repository = Repository();

  ShoppingListScreenVM({required this.products});
}
