import 'package:taesch/model/action.dart';
import 'package:taesch/model/product.dart';

abstract class IProductAction implements Action {

  Future<void> insertProduct(bool generated, Product product);

  Future<List<Product>> getProductList(bool generated);

  void deleteProduct(bool generated);

  void deleteProductList(bool generated);
}
