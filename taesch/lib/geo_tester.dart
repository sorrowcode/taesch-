// Code taken from https://www.flutterclutter.dev/flutter/tutorials/creating-a-geo-game/2020/1893/

import 'dart:ffi';

import 'package:http/http.dart';
import 'dart:convert';

class GeoTester{

  final String _apiUrl = 'overpass-api.de';
  final String _path = '/api/interpreter';
  Map<String, dynamic> _jsonMapData = Map();

  Future<void> makeHTTPRequest() async {
    Response resp = await get(Uri.parse("http://overpass-api.de//api/interpreter?data=[out:json][timeout:25];area(3602202162)->.searchArea;(nwr[\"shop\"=\"supermarket\"](around:2000,48.8534,2.3488)(area.searchArea););out;"));
    //http://overpass-api.de//api/interpreter?data=[out:json];node[highway=speed_camera](43.46669501043081,-5.708215989569187,43.588927989569186,-5.605835010430813);out%20meta;
    //?data=[bbox];node[amenity=post_box];out;&bbox=7.0,50.6,7.3,50.8
    //data=[out:json];node[highway=speed_camera](43.46669501043081,-5.708215989569187,43.588927989569186,-5.605835010430813);out%20meta;
    //data=[bbox];node[amenity=post_box];out;&bbox=7.0,50.6,7.3,50.8
    // implement a timeout for the await
    if (resp.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      _jsonMapData = jsonDecode(resp.body);
      //map.
      //print(resp.body);
      try {
        print("Content:");
        //print(_jsonMapData["elements"]);
        print(_jsonMapData["elements"][0]["lat"]);
        //Map<String, dynamic> innerJson = jsonDecode(_jsonMapData["elements"]);// as Map<String, dynamic>;
        //innerJson.forEach((k, v) => print("Key : $k, Value : $v"));
        List<MapSpot> spots = extractJSONData();
        print("done  :D");

      }catch(e){
        print("Couldn't print json data.");
      }
      return;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load map data.');
    }
    print("okkkkk");

    /*Request request = Request('GET', Uri.https(_apiUrl, _path));
    // do sth with request object

    String responseText;

    print("Sending request.");
    try{
      StreamedResponse response = await Client()
          .send(request)
          .timeout(const Duration(seconds: 5));

      responseText = await response.stream.bytesToString();
      print("received response from geo API.");
    }
    catch (exception) {
      print(exception);
      return Future.error(exception);
    }
    */
    return;
  }

  List<MapSpot> extractJSONData(){
    List<MapSpot> spotList = [];

    try{
      // data
      String elements = "elements";
      var elementList = _jsonMapData[elements];

      try{
        // Einträge extrahieren - data[elements]
        List<dynamic> elementContents = MyTools.getElements(elementList);
        int clength = elementContents.length<15 ? elementContents.length : 15;
        for (int i = 0; i<clength; i++) {

          try {
            // jeden Eintrag auslesen - data[elements][3]
            //List<dynamic> entryContents = MyTools.getElements(elementContents[i]);

            //try{
              // neues MapSpot-Objekt instanziieren - data[elements][3][name]
              // Initialisierung durch Zugriffe auf entryContents
              MapSpot mapSpot = MapSpot(elementContents[i]["name"], 4.0, 3.0);
              spotList.add(mapSpot);
            //}catch(e){
              //print("Mistake on MapSpot creation.");
            //}

          } catch (e) {
            print("Mistake on accessing or assigning elements-entry.");
          }
        }

      }catch(e){
        print("JSON conversion to list failed.");
      }

    }catch(e){
      print("No key \"elements\".");
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

  static List<dynamic> getElements(dynamic list){
    List<dynamic> result = [];
    bool endReached = false;
    int counter = 0;
    while (!endReached){
      try{
        result.add(list[counter]);
        counter++;
      }catch(e){
        endReached = true;
        print("counter = "+counter.toString());
      }
    }
    return result;
  }
}