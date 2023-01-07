enum MapSpotKeys {
  name,
  latitude,
  longitude,
  street,
  postcode,
  houseNumber
}

extension MapSpotKeysString on MapSpotKeys {
  String text() {
    switch(this) {
      case MapSpotKeys.name:
        return "name";
      case MapSpotKeys.latitude:
        return "latitude";
      case MapSpotKeys.longitude:
        return "longitude";
      case MapSpotKeys.street:
        return "street";
      case MapSpotKeys.postcode:
        return "postcode";
      case MapSpotKeys.houseNumber:
        return "houseNumber";
    }
  }
}