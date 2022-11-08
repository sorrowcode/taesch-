class MapQueryIndexes {
  final String name = "name";
  final String latitude = "lat";
  final String longitude = "long";
}

class OSMQueries {
  final String query1Heilbronn =
      "data=[out:json][timeout:50];area[name=\"Heilbronn\"]->.searchArea;(nwr[\"shop\"=\"supermarket\"](around:2000,49.1427,9.2109)(area.searchArea););out;";
  final String queryTestAreaParis =
      "data=[out:json][timeout:25];area(3602202162)->.searchArea;(nwr[\"shop\"=\"supermarket\"](around:2000,48.8534,2.3488)(area.searchArea););out;";
  final String queryTestBoundingBoxPostBox =
      "data=[bbox];node[amenity=post_box];out;&bbox=7.0,50.6,7.3,50.8";
  final String queryTestHighspeedCameras =
      "data=[out:json];node[highway=speed_camera](43.46669501043081,-5.708215989569187,43.588927989569186,-5.605835010430813);out%20meta;";

  final int queryTimeoutSeconds = 4;

  String OSMQueryBuilder() {
    // zunächst ein Defaultwert. In Zukunft sollen weitere Parameter gesetzt werden können.
    return query1Heilbronn;
  }
}
