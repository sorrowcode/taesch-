enum OverpassQueryIndexes {
  name,
  latitude,
  longitude,
  street,
  houseNumber,
}

extension OverpassQueryJSONIndexesValues on OverpassQueryIndexes{
  String get identifier{
    switch(this){
      case OverpassQueryIndexes.name:
        return "name";
      case OverpassQueryIndexes.latitude:
        return "lat";
      case OverpassQueryIndexes.longitude:
        return "lon";
      case OverpassQueryIndexes.street:
        return "addr:street";
      case OverpassQueryIndexes.houseNumber:
        return "addr:housenumber";
    }
  }
}