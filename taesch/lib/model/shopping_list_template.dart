import 'package:taesch/model/product.dart';

class ShoppingListTemplate {
  static List<ShoppingListTemplate> templates = [];
  List<Product> _products = [];
  
  ShoppingListTemplate() {
    templates.add(this);
  }
  
  // todo: add elements
  void addProduct(Product product) {
    // todo: direkt persistieren?
  }

  // todo: delete elements
  void delete(Product product) {
    // todo: direkt persistieren?
  }

  // todo: update elements
  void update(Product product) {
    // todo: direkt persistieren?
  }
}