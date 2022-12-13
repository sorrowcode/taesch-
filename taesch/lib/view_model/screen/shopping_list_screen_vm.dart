import 'package:taesch/api/repositories/repository_type.dart';
import 'package:taesch/api/repositories/sql_repository.dart';
import 'package:taesch/api/repository_holder.dart';
import 'package:taesch/model/product.dart';
import 'package:taesch/view/screen/shopping_list_screen.dart';

/// vm for [ShoppingListScreen]
class ShoppingListScreenVM {
  List<Product> products;
  SQLRepository sqlRepository = (RepositoryHolder()
      .getRepositoryByType(RepositoryType.sql) as SQLRepository);

  ShoppingListScreenVM({required this.products});
}
