enum ProductKeys {
  name,
  imageUrl,
  quantity,
}

extension ProductKeyString on ProductKeys {

  String text() {
    switch (this) {
      case ProductKeys.name:
        return "name";
      case ProductKeys.imageUrl:
        return "imageUrl";
      case ProductKeys.quantity:
        return "quantity";
    }
  }
}