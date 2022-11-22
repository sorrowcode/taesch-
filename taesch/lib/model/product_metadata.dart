class ProductMetadata {
  double positionValue = 0;
  double sumOfAllWeights = 0;
  int timesBought = 0;

  ProductMetadata();

  ProductMetadata.fromMap(
      {required this.positionValue,
      required this.sumOfAllWeights,
      required this.timesBought});
}
