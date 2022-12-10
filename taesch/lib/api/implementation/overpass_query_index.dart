enum OverpassQueryIndex {
  name,
  latitude,
  longitude,
  street,
  houseNumber,
  postcode,
}

extension OverpassQueryJSONIndexesValues on OverpassQueryIndex {
  String get identifier {
    switch (this) {
      case OverpassQueryIndex.name:
        return "name";
      case OverpassQueryIndex.latitude:
        return "lat";
      case OverpassQueryIndex.longitude:
        return "lon";
      case OverpassQueryIndex.street:
        return "addr:street";
      case OverpassQueryIndex.houseNumber:
        return "addr:housenumber";
      case OverpassQueryIndex.postcode:
        return "addr:postcode";
    }
  }
}