enum ProductMetadataKeys { positionValue, sumOfAllWeights, timesBought }

extension ProductMetadataKeysString on ProductMetadataKeys {
  String text() {
    switch (this) {
      case ProductMetadataKeys.positionValue:
        return "positionValue";
      case ProductMetadataKeys.sumOfAllWeights:
        return "sumOfAllWeights";
      case ProductMetadataKeys.timesBought:
        return "timesBought";
    }
  }
}
