// Code snippets taken from https://www.flutterclutter.dev/flutter/tutorials/creating-a-geo-game/2020/1893/

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:taesch/api/map_api_logic/overpass_query_indexes.dart';
import 'package:taesch/api/repository.dart';
import 'package:taesch/exceptions/custom/query_exceptions.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/log_message.dart';
import 'package:taesch/model/map_spot.dart';


// import 'package:taesch/utils/my_tools.dart';

// import 'geolocation_tools.dart';
// import 'querying_tools.dart';

class APIQuerier {
  LoggerWrapper logger = LoggerWrapper();
  final Repository repository = Repository();
  final String _apiUrl = 'http://overpass-api.de//api/interpreter?';
  Map<String, dynamic> _jsonMapData = {};

  Future<void> makeHTTPRequest() async {
      try {
        // build http request and set timeout
        Response resp = await get(
            Uri.parse(_apiUrl + repository.queries.osmQueryBuilder()))
            .timeout(Duration(milliseconds: 1000*repository.queries.queryTimeoutSeconds));
         //print("got response");

        if (resp.statusCode == 200) {
          // If the server did return a 200 OK response,
          // then parse the JSON.
          _jsonMapData = jsonDecode(utf8.decode(resp.body.codeUnits));
          //print(_jsonMapData.toString());

          /*try {
          // List<MapSpot> spots = extractJSONData();
          } catch (e) {
          //print("Couldn't extract json data.");
          }*/

          //print("Done processing response.");

          //MyTools.spawnIsolate(GeolocationTools.getCurrentPosition);
          return;
        } else {
          // If the server did not return a 200 OK response,
          // then throw an exception.
          // throw Exception('Error on sending http request.');
          logger.log(
              level: LogLevel.error,
              logMessage: LogMessage(
                  message: "Error on sending http request. Did not receive a 200 OK response.")
          );
        }
      } on TimeoutException catch (e) {
        //print("Timeout for http request.");
        logger.log(
            level: LogLevel.error,
            logMessage: LogMessage(
                message: "Timeout for HTTP Geo-request:\n${e.toString()}")
        );
      }
      on Exception catch (e) {
        logger.log(
            level: LogLevel.error,
            logMessage: LogMessage(
                message: "A different exception:\n${e.toString()}")
        );
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
        List<dynamic> elementContents =
            repository.tools.getElements(list: elementList);

        // int clength = elementContents.length<15 ? elementContents.length : 15;
        int clength = elementContents.length;
        for (int i = 0; i < clength; i++) {
          try {
            // jeden Eintrag auslesen - data[elements][3]
            // List<dynamic> entryContents = MyTools.getElements(list: elementContents[i]);
            var entries = elementContents[i];

            // neues MapSpot-Objekt instanziieren - data[elements][3][name]
            // Initialisierung durch Zugriffe auf entryContents
            try {
              String noValue = "no value", accessedValue = noValue;

              double latitude = 0.0;
              accessedValue = noValue;
              try {
                accessedValue = entries[
                        OverpassQueryIndexes.latitude.identifier]
                    .toString(); // .toString is necessary, otherwise parsing fails
                latitude = double.parse(accessedValue);
              } catch (e) {
                try {
                  throw QueryException(
                      cause:
                          "Parsing of accessed latitude index to double failed. Value: $accessedValue");
                } on QueryException catch (f) {
                  logger.log(
                      level: LogLevel.error,
                      logMessage: LogMessage(
                          message: f.cause)
                  );
                }
              }

              double longitude = 0.0;
              accessedValue = noValue;
              try {
                accessedValue =
                    entries[OverpassQueryIndexes.longitude.identifier]
                        .toString();
                longitude = double.parse(accessedValue);
              } catch (e) {
                try {
                  throw QueryException(
                      cause:
                          "Parsing of accessed longitude index to double failed. Value: $accessedValue");
                } on QueryException catch (f) {
                  logger.log(
                      level: LogLevel.error,
                      logMessage: LogMessage(
                          message: f.cause)
                  );
                }
              }

              var tags = entries["tags"];

              String name = "n/a";
              accessedValue = noValue;
              try {
                accessedValue =
                    tags[OverpassQueryIndexes.name.identifier]; //.toString()
                name = accessedValue;
              } catch (e) {
                try {
                  throw QueryException(
                      cause:
                          "Accessing name index failed. Value: $accessedValue");
                } on QueryException catch (f) {
                  //f.cause; // <- needs to be logged
                  logger.log(
                      level: LogLevel.error,
                      logMessage: LogMessage(
                          message: f.cause)
                  );
                }
              }

              String street = "n/a";
              accessedValue = noValue;
              try {
                accessedValue =
                    tags[OverpassQueryIndexes.street.identifier]; //.toString();
                street = accessedValue;
              } catch (e) {
                try {
                  throw QueryException(
                      cause:
                          "Accessing street index failed. Value: $accessedValue");
                } on QueryException catch (f) {
                  logger.log(
                      level: LogLevel.error,
                      logMessage: LogMessage(
                          message: f.cause)
                  );
                }
              }

              String number = "n/a";
              accessedValue = noValue;
              try {
                accessedValue =
                    tags[OverpassQueryIndexes.houseNumber.identifier]; //.toString
                number = accessedValue;
              } catch (e) {
                try {
                  throw QueryException(
                      cause:
                          "Accessing street-number index failed. Value: $accessedValue");
                } on QueryException catch (f) {
                  logger.log(
                      level: LogLevel.error,
                      logMessage: LogMessage(
                          message: f.cause)
                  );
                }
              }

              MapSpot mapSpot =
                  MapSpot(name, longitude, latitude, "$street, $number");
              spotList.add(mapSpot);

              // it seems like the JSON-response itself is capped to a maximum number of values
              // for this reason (probably) one isn't able to access all the information (like lat, long)
              // and sometimes it just isn't in the response body at all (even if it's only a few elements)

            } catch (e) {
              logger.log(
                  level: LogLevel.error,
                  logMessage: LogMessage(
                      message: "Something has gone wrong during extraction of JSON-data:\n${e.toString()}")
              );
            }
          } catch (e) {
            logger.log(
                level: LogLevel.error,
                logMessage: LogMessage(
                    message: "Mistake on accessing or assigning elements-entry:\n${e.toString()}")
            );
          }
        }
      } catch (e) {
        logger.log(
            level: LogLevel.error,
            logMessage: LogMessage(
                message: "JSON conversion to list failed:\n${e.toString()}")
        );
      }
    } catch (e) {
      logger.log(
          level: LogLevel.error,
          logMessage: LogMessage(
              message: "The specified key does not exist:\n${e.toString()}")
      );
    }
    //dataList.add();
    return spotList;
  }
}
