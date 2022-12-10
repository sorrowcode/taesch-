import 'package:taesch/api/mapper/product_dto_map_data.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/log_message.dart';
import 'package:taesch/model/product.dart';
import 'package:taesch/model/product_metadata.dart';
import 'package:taesch/model/tag.dart';

class ProductDTO {
  late Product product;
  late Map<String, dynamic> map;
  LoggerWrapper logger = LoggerWrapper();

  ProductDTO.fromProduct({required this.product});

  ProductDTO.fromMap({required this.map});

  void toMap() {
    List<String> tags = [];
    for (Tag tag in product.tags) {
      tags.add(tag.name);
    }
    map = {
      ProductDTOMapData.name.value(): product.name,
      ProductDTOMapData.imageUrl.value(): product.imageUrl,
      ProductDTOMapData.quantity.value(): product.quantity,
      ProductDTOMapData.tags.value(): tags.toString(),
      ProductDTOMapData.positionValue.value(): product.metadata.positionValue,
      ProductDTOMapData.sumOfAllWeights.value():
          product.metadata.sumOfAllWeights,
      ProductDTOMapData.timesBought.value(): product.metadata.timesBought,
    };
    logger.log(
        level: LogLevel.debug,
        logMessage: LogMessage(message: "mapping product to map:\n $map"));
  }

  void toProduct() {
    String stings = map[ProductDTOMapData.tags.value()];
    stings.replaceAll("[", "");
    stings.replaceAll("]", "");
    List<String> list = stings.split(", ");
    List<Tag> tags = [];
    for (String tagName in list) {
      tags.add(Tag(name: tagName));
    }
    logger.log(
        level: LogLevel.debug,
        logMessage: LogMessage(message: "mapping map to product\n$map"));
    product = Product.fromMap(
        name: map[ProductDTOMapData.name.value()],
        imageUrl: map[ProductDTOMapData.imageUrl.value()],
        quantity: map[ProductDTOMapData.quantity.value()],
        tags: tags,
        metadata: ProductMetadata.fromMap(
            positionValue: map[ProductDTOMapData.positionValue.value()],
            sumOfAllWeights: map[ProductDTOMapData.sumOfAllWeights.value()],
            timesBought: map[ProductDTOMapData.timesBought.value()]));
  }
}
