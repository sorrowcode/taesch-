

import '../../api/repositories/repository_type.dart';
import '../../api/repositories/sql_repository.dart';
import '../../api/repository_holder.dart';
import '../../model/product.dart';

/// vm for [ShoppingListTemplatesScreenScreen]
class ShoppingListTemplatesScreenVM{
  List<Product> products;
  SQLRepository sqlRepository = (RepositoryHolder()
      .getRepositoryByType(RepositoryType.sql) as SQLRepository);

  ShoppingListTemplatesScreenVM({required this.products});
}