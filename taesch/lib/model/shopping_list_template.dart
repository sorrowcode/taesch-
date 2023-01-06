import 'package:taesch/model/product.dart';

class ShoppingListTemplate {
  static final List<ShoppingListTemplate> templates = [];
  //List<Product> _products = [];

  ShoppingListTemplate() {
    templates.add(this);
  }

  // todo: add elements
  void addProduct(Product product) {
    // todo: direkt persistieren?
    // todo: firebase - produkt hinzufügen und _products aktualisieren
  }

  // todo: delete elements
  void delete(Product product) {
    // todo: direkt persistieren?
    // todo: firebase - produkt löschen und _products aktualisieren
  }

  // todo: update elements
  void update(Product product) {
    // todo: direkt persistieren?
    // todo: firebase - produkt aktualisieren und _products aktualisieren
  }
}
