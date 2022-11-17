import 'package:taesch/model/action.dart';
import 'package:taesch/model/product.dart';

abstract class IProductAction implements Action {
  void insertGeneratedProductList(List<Product> products);

  void insertEffectiveProduct(Product product);

  List<Product> getGeneratedProductList();

  Future<List<Product>> getEffectiveProductList();

  Product getGeneratedProduct();

  Product getEffectiveProduct();

  void deleteGeneratedProduct();

  void deleteEffectiveProduct();

  void deleteGeneratedProductList();

  void deleteEffectiveProductList();
}
