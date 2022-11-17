enum ProductDTOMapData {
  name,
  imageUrl,
  quantity,
  tags,
  positionValue,
  sumOfAllWeights,
  timesBought
}

extension ProductDTOMapDataString on ProductDTOMapData {
  String value() {
    switch (this) {
      case ProductDTOMapData.name:
        return "name";
      case ProductDTOMapData.imageUrl:
        return "imageUrl";
      case ProductDTOMapData.quantity:
        return "quantity";
      case ProductDTOMapData.tags:
        return "tags";
      case ProductDTOMapData.positionValue:
        return "positionValue";
      case ProductDTOMapData.sumOfAllWeights:
        return "sumOfAllWeights";
      case ProductDTOMapData.timesBought:
        return "timesBought";
    }
  }
}
