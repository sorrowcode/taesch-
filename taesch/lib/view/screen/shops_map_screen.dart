import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/log_message.dart';
import 'package:taesch/model/map_spot.dart';
import 'package:taesch/model/shop.dart';
import 'package:taesch/view_model/screen/shops_map_screen_vm.dart';

class ShopsMapScreen extends StatefulWidget {
  final _vm = ShopsMapScreenVM();

  ShopsMapScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ShopsMapScreenState();
}

class _ShopsMapScreenState extends State<ShopsMapScreen> {
  LoggerWrapper logger = LoggerWrapper();
  int _onTapId = 0;

  List<Marker> _getMarkersFromSpot(List<MapSpot> mapSpots) {
    List<Marker> markers = [];
    int idCounter=0;
    for (MapSpot mapSpot in mapSpots) {
      idCounter++;
      int markerID = idCounter;
      Text markerDescriptor = const Text("");

      if (_onTapId == markerID){
        markerDescriptor = Text("${mapSpot.name}\n${mapSpot.address}");
      }else{
        //markerDescriptor = const Text("");
      }

      markers.add(Marker(
          width: 200,
          height: 300,
          key: ValueKey(markerID),
          point: LatLng(mapSpot.lat, mapSpot.long),
          builder: (ctx) => GestureDetector(
            onTap: () {
              setState(() {
                // show information only for this marker
                _onTapId = markerID;
              });
            },

            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  markerDescriptor,
                  const Center(
                      child: Icon(Icons.location_on)
                  )
                ]
            ),
          )
      )
      );
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    logger.log(
        level: LogLevel.info,
        logMessage: LogMessage(message: "entered shops map screen"));

    // create user position object
    Position position = widget._vm.repository.userPosition;

    // fetch MapSpots from each Shop
    List<MapSpot> mapSpots = [];
    for (Shop shop in widget._vm.repository.shopsCache) {
      mapSpots.add(shop.mapSpot);
    }

    // taken from the example code of https://github.com/fleaflet/flutter_map/blob/master/example/lib/pages/moving_markers.dart
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(position.latitude, position.longitude),
              zoom: 13,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
              ),
              MarkerLayer(
                markers: [
                      Marker(
                          point: LatLng(position.latitude, position.longitude),
                          builder: (ctx) => GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                  Icons.my_location) //const FlutterLogo(),
                              ))
                    ] +
                    _getMarkersFromSpot(mapSpots),
              )
            ],
          ),
        ),
      ),
    );
  }
}
