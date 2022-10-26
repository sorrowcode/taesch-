class ShoppingItem {
  String title;
  String image;
  int bought = 0;

  ShoppingItem(this.title, this.image);

  ShoppingItem.db(
      {required this.title, required this.image, required this.bought});

  void toggleBought() => bought = bought > 0 ? 0 : 1;

  Map<String, dynamic> toMap() {
    return {'item_title': title, 'image': image, 'bought': bought};
  }

  @override
  String toString() {
    return 'ShoppingItem{"item_title":"$title", "image":"$image", "bought":$bought}';
  }
}
