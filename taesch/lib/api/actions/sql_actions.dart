import 'package:taesch/api/actions/actions.dart';
import 'package:taesch/model/product.dart';

abstract class SQLActions implements Actions {

  Future<void> insertProduct(bool generated, Product product);

  Future<List<Product>> getProductList(bool generated);

  Future<void> deleteProduct(bool generated, String productName);

  Future<void> deleteProductList(bool generated);
}
