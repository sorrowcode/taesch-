import 'package:taesch/model/product_metadata.dart';
import 'package:taesch/model/tag.dart';

class Product {
  final String name;
  final String imageUrl;
  late int quantity = 1;
  late List<Tag> tags;
  ProductMetadata metadata = ProductMetadata();

  Product({required this.name, required this.imageUrl}) {
    tags = [Tag(name: "testTag")];
  }

  Product.fromMap(
      {required this.name,
      required this.imageUrl,
      required this.quantity,
      required this.tags,
      required this.metadata});
}
