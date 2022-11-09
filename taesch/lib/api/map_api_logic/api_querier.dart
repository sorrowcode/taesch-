// Code snippets taken from https://www.flutterclutter.dev/flutter/tutorials/creating-a-geo-game/2020/1893/

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:taesch/api/map_api_logic/overpass_query_indexes.dart';
import 'package:taesch/model/map_spot.dart';
import 'package:taesch/utils/my_tools.dart';

import 'querying_tools.dart';

class APIQuerier {
  final String _apiUrl = 'http://overpass-api.de//api/interpreter?';
  Map<String, dynamic> _jsonMapData = {};

  Future<void> makeHTTPRequest() async {
    try {
      // build http request and set timeout
      Response resp =
          await get(Uri.parse(_apiUrl + OSMQueries.OSMQueryBuilder()))
              .timeout(const Duration(seconds: OSMQueries.queryTimeoutSeconds));

      if (resp.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        _jsonMapData = jsonDecode(resp.body);

        try {
          // List<MapSpot> spots = extractJSONData();
        } catch (e) {
          //print("Couldn't extract json data.");
        }

        //print("Done processing response.");
        return;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Error on sending http request.');
      }
    } on TimeoutException catch (e) {
      //print("Timeout for http request.");
    }
  }

  List<MapSpot> extractJSONData() {
    List<MapSpot> spotList = [];

    try {
      // data
      String elements = "elements";
      var elementList = _jsonMapData[elements];

      try {
        // Einträge extrahieren - data[elements]
        List<dynamic> elementContents = MyTools.getElements(list: elementList);
        // int clength = elementContents.length<15 ? elementContents.length : 15;
        int clength = elementContents.length;
        for (int i = 0; i < clength; i++) {
          try {
            // jeden Eintrag auslesen - data[elements][3]
            // List<dynamic> entryContents = MyTools.getElements(list: elementContents[i]);
            var entries = elementContents[i];
            try {
              // neues MapSpot-Objekt instanziieren - data[elements][3][name]
              // Initialisierung durch Zugriffe auf entryContents
              try {
                double latitude = 0.0;
                try {
                  latitude = double.parse(
                      entries[OverpassQueryIndexes.latitude.identifier]
                          .toString());
                  // .toString is necessary, otherwise parsing fails
                } catch (e) {}

                double longitude = 0.0;
                try {
                  longitude = double.parse(
                      entries[OverpassQueryIndexes.longitude.identifier]
                          .toString());
                } catch (e) {}

                var tags = entries["tags"];

                String name = "n/a";
                try {
                  name = tags[OverpassQueryIndexes.name.identifier];
                } catch (e) {}

                String street = "n/a";
                try {
                  street = tags[OverpassQueryIndexes.street];
                } catch (e) {}

                String number = "n/a";
                try {
                  number = tags[OverpassQueryIndexes.houseNumber];
                } catch (e) {}

                MapSpot mapSpot =
                    MapSpot(name, longitude, latitude, "$street, $number");
                spotList.add(mapSpot);
              } catch (e) {}
            } catch (e) {
              //print("Mistake on MapSpot creation.");
            }
          } catch (e) {
            //print("Mistake on accessing or assigning elements-entry.");
          }
        }
      } catch (e) {
        //print("JSON conversion to list failed.");
      }
    } catch (e) {
      //print("The specified key does not exist.");
    }
    //dataList.add();
    return spotList;
  }
}
