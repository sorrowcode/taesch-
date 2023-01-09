class MapSpot {
  final String name;
  final double latitude;
  final double longitude;
  final String street;
  final int postcode;
  final String houseNumber;

  MapSpot(
      {required this.name,
      required this.latitude,
      required this.longitude,
      required this.street,
      required this.houseNumber,
      required this.postcode});
}
