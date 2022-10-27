class MapQueryIndexes {
  static const String name = "name";
  static const String latitude = "lat";
  static const String longitude = "long";
}

class OSMQueries {
  static const String query1Heilbronn =
      "data=[out:json][timeout:50];area[name=\"Heilbronn\"]->.searchArea;(nwr[\"shop\"=\"supermarket\"](around:2000,49.1427,9.2109)(area.searchArea););out;";
  static const String queryTestAreaParis =
      "data=[out:json][timeout:25];area(3602202162)->.searchArea;(nwr[\"shop\"=\"supermarket\"](around:2000,48.8534,2.3488)(area.searchArea););out;";
  static const String queryTestBoundingBoxPostBox =
      "data=[bbox];node[amenity=post_box];out;&bbox=7.0,50.6,7.3,50.8";
  static const String queryTestHighspeedCameras =
      "data=[out:json];node[highway=speed_camera](43.46669501043081,-5.708215989569187,43.588927989569186,-5.605835010430813);out%20meta;";

  static const int queryTimeoutSeconds = 4;

  static String OSMQueryBuilder() {
    // zunächst ein Defaultwert. In Zukunft sollen weitere Parameter gesetzt werden können.
    return OSMQueries.query1Heilbronn;
  }
}
