import 'package:taesch/model/product.dart';
import 'package:taesch/model/shop.dart';

class Purchase {
  Shop shop;
  List<Product> productsBought;

  Purchase({required this.shop, required this.productsBought});
}