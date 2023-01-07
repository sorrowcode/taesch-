import 'dart:collection';

import 'package:taesch/model/keys/product_keys.dart';
import 'package:taesch/model/product_metadata.dart';
import 'package:taesch/model/tag.dart';

import 'keys/product_metadata_keys.dart';

class Product {
  late final String name;
  late final String imageUrl;
  late int quantity = 1;
  late List<Tag> tags;
  late ProductMetadata metadata;

  Product({required this.name, required this.imageUrl}) {
    tags = [Tag(name: "testTag")];
    metadata = ProductMetadata();
  }

  Product.fromMap(Map<String, dynamic> map) {
    name = map[ProductKeys.name.text()].toString();
    imageUrl = map[ProductKeys.imageUrl.text()].toString();
    quantity = int.parse(map[ProductKeys.quantity.text()].toString());
    metadata = ProductMetadata.withData(
        positionValue: double.parse(map[ProductMetadataKeys.positionValue.text()].toString()),
        sumOfAllWeights: double.parse(map[ProductMetadataKeys.sumOfAllWeights.text()].toString()),
        timesBought: int.parse(map[ProductMetadataKeys.timesBought.text()].toString())
    );
  }

  Map<String, dynamic> toMap() {
    HashMap<String, dynamic> map = HashMap();
    map.putIfAbsent(ProductKeys.name.text(), () => name);
    map.putIfAbsent(ProductKeys.imageUrl.text(), () => imageUrl);
    map.putIfAbsent(ProductKeys.quantity.text(), () => quantity);
    map.putIfAbsent(ProductMetadataKeys.positionValue.text(), () => metadata.positionValue);
    map.putIfAbsent(ProductMetadataKeys.sumOfAllWeights.text(), () => metadata.sumOfAllWeights);
    map.putIfAbsent(ProductMetadataKeys.timesBought.text(), () => metadata.timesBought);
    return map;
  }
}
