import 'package:objectid/objectid.dart';
import 'package:taesch/model/tag.dart';

class ShoppingListItem {
  late final ObjectId _id;
  final String title;
  final String image;
  final List<Tag> tags = [];
  double weight = 0;

  ShoppingListItem({required this.title, required this.image}){
    _id = ObjectId();
  }

  ShoppingListItem.db(
      {required String id, required this.title, required this.image,
        required this.weight}){
    _id = ObjectId.fromHexString(id);
  }

  get id => (_id.hexString);

  Map<String, dynamic> toMap() {
    return {'id': _id.hexString, 'item_title': title,
      'image': image, 'weight': weight};
  }

  @override
  String toString() {
    return 'ShoppingItem{"id":"$_id", "item_title":"$title", "image":"$image", "weight":$weight}';
  }
}
