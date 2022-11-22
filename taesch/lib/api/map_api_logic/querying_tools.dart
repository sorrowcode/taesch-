import 'package:latlong2/latlong.dart';
import 'package:taesch/model/query_location.dart';

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
  final int maxSearchRadius = 10000;
  final int minSearchRadius = 5;

  int _searchRadius = 2000;
  double _locationLat = 0.0;
  double _locationLong = 0.0;
  QueryLocation _fixedLocation = QueryLocation.heilbronn;

  void setSearchRadiusMeters(int meters){
    int newMeters = meters;
    if (newMeters>maxSearchRadius){
      newMeters = maxSearchRadius;
    }else if (newMeters<minSearchRadius){
      newMeters = minSearchRadius;
    }
    _searchRadius = newMeters;
  }

  int getSearchRadiusMeters(){
    return _searchRadius;
  }

  void setQueryLocation(QueryLocation queryLocation){
    _fixedLocation = queryLocation;
  }

  QueryLocation getQueryLocation(){
    return _fixedLocation;
  }

  void setCustomLocation(LatLng position){
    _locationLat = position.latitude;
    _locationLong = position.longitude;
  }

  LatLng getCustomLocation(){
    return LatLng(_locationLat, _locationLong);
  }

  String osmQueryBuilder() {

    // logic that assembles the Overpass query

    String query = "";
    String locationName = _fixedLocation.location;
    String searchRadius = _searchRadius.toString();
    String latitude = _locationLat.toString();
    String longitude = _locationLong.toString();

    String staticPart1 = "data=[out:json][timeout:50];area[name=\"";// <- may alter timeout variable
    String staticPart2 = "\"]->.searchArea;(nwr[\"shop\"=\"supermarket\"](around:";
    String staticPart3 = ")(area.searchArea););out;";

    query+=staticPart1;
    query+=locationName;
    query+=staticPart2;
    query+="$searchRadius,";
    query+="$latitude,";
    query+=longitude;
    query+=staticPart3;

    //return query1Heilbronn;
    return query;
  }
}

class OSMQueryBuilder {}
