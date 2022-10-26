// Code snippets taken from https://www.flutterclutter.dev/flutter/tutorials/creating-a-geo-game/2020/1893/

import 'dart:async';

import 'package:http/http.dart';
import 'dart:convert';

class GeoTester{

  final String _apiUrl = 'http://overpass-api.de//api/interpreter?';
  Map<String, dynamic> _jsonMapData = Map();

  Future<void> makeHTTPRequest() async {
    try {
      // build http request and set timeout
      Response resp = await get(Uri.parse(_apiUrl + OSMQueries.OSMQueryBuilder()))
          .timeout(const Duration(seconds: OSMQueries.queryTimeoutSeconds));

      if (resp.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        _jsonMapData = jsonDecode(resp.body);

        try {
          List<MapSpot> spots = extractJSONData();
        } catch (e) {
          print("Couldn't extract json data.");
        }

        return;

      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Error on sending http request.');
      }
    }on TimeoutException catch(e){
      print("Timeout for http request.");
    }

  }

  List<MapSpot> extractJSONData(){
    List<MapSpot> spotList = [];

    try{
      // data
      String elements = "elements";
      var elementList = _jsonMapData[elements];

      try{
        // Einträge extrahieren - data[elements]
        List<dynamic> elementContents = MyTools.getElements(list: elementList);
        int clength = elementContents.length<15 ? elementContents.length : 15;
        for (int i = 0; i<clength; i++) {

          try {
            // jeden Eintrag auslesen - data[elements][3]
            // List<dynamic> entryContents = MyTools.getElements(list: elementContents[i]);
            var entries = elementContents[i];
            try{
              // neues MapSpot-Objekt instanziieren - data[elements][3][name]
              // Initialisierung durch Zugriffe auf entryContents
              MapSpot mapSpot = MapSpot(entries["type"], 4.0, 3.0);
              spotList.add(mapSpot);
            }catch(e){
              print("Mistake on MapSpot creation.");
            }

          } catch (e) {
            print("Mistake on accessing or assigning elements-entry.");
          }
        }

      }catch(e){
        print("JSON conversion to list failed.");
      }

    }catch(e){
      print("The specified key does not exist.");
    }
    //dataList.add();
    return spotList;
  }

}

class MapSpot{

  final String name;
  final double long;
  final double lat;

  MapSpot(this.name, this.long, this.lat);

}

class MyTools{

  static List<dynamic> getElements({required dynamic list, int cap = 0}){
    List<dynamic> result = [];
    bool capSet = cap>0 ? true : false;
    bool endReached = false;
    int counter = 0;
    while (!endReached){
      try{
        result.add(list[counter]);
        counter++;
        if (capSet){
          if (counter>cap) endReached=true;
        }
      }catch(e){
        endReached = true;
        print("counter = "+counter.toString());
      }
    }
    return result;
  }
}

class MapQueryIndexes{
  static const String name = "name";
  static const String latitude = "lat";
  static const String longitude = "long";
}

class OSMQueries{
  static const String query1Heilbronn = "data=[out:json][timeout:50];area[name=\"Heilbronn\"]->.searchArea;(nwr[\"shop\"=\"supermarket\"](around:2000,49.1427,9.2109)(area.searchArea););out;";
  static const String queryTestAreaParis = "data=[out:json][timeout:25];area(3602202162)->.searchArea;(nwr[\"shop\"=\"supermarket\"](around:2000,48.8534,2.3488)(area.searchArea););out;";
  static const String queryTestBoundingBoxPostBox = "data=[bbox];node[amenity=post_box];out;&bbox=7.0,50.6,7.3,50.8";
  static const String queryTestHighspeedCameras = "data=[out:json];node[highway=speed_camera](43.46669501043081,-5.708215989569187,43.588927989569186,-5.605835010430813);out%20meta;";

  static const int queryTimeoutSeconds = 4;
  
  static String OSMQueryBuilder(){
    // zunächst ein Defaultwert. In Zukunft sollen weitere Parameter gesetzt werden können.
    return OSMQueries.query1Heilbronn;
  }
}