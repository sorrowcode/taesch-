enum QueryLocation { heilbronn, neckarsulm, karlsruhe, stuttgart }

extension LocationName on QueryLocation {
  String get location {
    switch (this) {
      case QueryLocation.heilbronn:
        return "Heilbronn";
      case QueryLocation.neckarsulm:
        return "Neckarsulm";
      case QueryLocation.karlsruhe:
        return "Karlsruhe";
      case QueryLocation.stuttgart:
        return "Stuttgart";
    }
  }
}
