import 'package:taesch/model/tag.dart';

class ShoppingListItem {
  String title;
  String image;
  List<Tag> tags = [];
  double weight = 0;

  ShoppingListItem(this.title, this.image);

  ShoppingListItem.db(
      {required this.title, required this.image, required this.weight});

  Map<String, dynamic> toMap() {
    return {'item_title': title, 'image': image, 'weight': weight};
  }

  @override
  String toString() {
    return 'ShoppingItem{"item_title":"$title", "image":"$image", "weight":$weight}';
  }
}
