
class ShoppingItem{
  String title;
  String image;
  bool bought = false;
  ShoppingItem(this.title, this.image);
  ShoppingItem.db({required this.title, required this.image, required this.bought});

  void toggleBought(){
    bought = !bought;
  }

  Map<String, dynamic> toMap(){
    return {
      'item_title': title,
      'image': image,
      'bought': bought
    };
  }

}