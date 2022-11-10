import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:taesch/model/map_spot.dart';
import 'package:taesch/view_model/screen/shops_map_screen_vm.dart';

import '../../model/shop.dart';

class ShopsMapScreen extends StatefulWidget {
  final _vm = ShopsMapScreenVM();

  ShopsMapScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ShopsMapScreenState();
}

class _ShopsMapScreenState extends State<ShopsMapScreen> {
  List<Marker> _getMarkersFromSpot(List<MapSpot> mapSpots) {
    List<Marker> markers = [];
    for (MapSpot mapSpot in mapSpots) {
      markers.add(Marker(
          point: LatLng(mapSpot.lat, mapSpot.long),
          /*builder: (ctx) => GestureDetector(
                        onTap: () {
                            /*ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
                                content: Text('Tapped on blue FlutterLogo Marker'),
                                )
                            );*/
                            print("Tapped on marker.");
                        },
                        child: Icon(Icons.location_on),

                    )*/
          builder: (ctx) => const Icon(Icons.location_on)));
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
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
