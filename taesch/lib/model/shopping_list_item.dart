import 'package:taesch/model/tag.dart';

class ShoppingListItem {
  final String title;
  final String image;
  final List<Tag> tags = [];
  double weight = 0;

  ShoppingListItem({required this.title, required this.image});

  ShoppingListItem.db(
      {required this.title, required this.image, required this.weight});

  Map<String, dynamic> toMap() {
    return {'item_title': title, 'image': image, 'weight': weight};
  }

  @override
  String toString() {
    return 'ShoppingItem{"item_title":"$title", "image":"$image", "weight":$weight, "tags":$tags}';
  }
}
