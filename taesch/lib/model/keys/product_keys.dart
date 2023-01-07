enum ProductKeys {
  name,
  quantity,
}

extension ProductKeyString on ProductKeys {

  String text() {
    switch (this) {
      case ProductKeys.name:
        return "name";
      case ProductKeys.quantity:
        return "quantity";
    }
  }
}