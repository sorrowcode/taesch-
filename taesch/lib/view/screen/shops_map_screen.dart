import 'package:flutter/material.dart';
import 'package:taesch/view_model/screen/shops_map_screen_vm.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../model/map_spot.dart';

class ShopsMapScreen extends StatefulWidget{
    final _vm = ShopsMapScreenVM();

    ShopsMapScreen({super.key});

    @override
    State<StatefulWidget> createState() => _ShopsMapScreenState();
}

class _ShopsMapScreenState extends State<ShopsMapScreen>{

    List<Marker> _getMarkersFromSpot(List<MapSpot> mapSpots){
        List<Marker> markers = [];
        for (MapSpot mapSpot in mapSpots){
            markers.add(
                Marker(
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
                    builder: (ctx) => const Icon(Icons.location_on)
                )
            );
        }
        return markers;
    }

    @override
    Widget build(BuildContext context) {

        // taken from the example code of https://github.com/fleaflet/flutter_map/blob/master/example/lib/pages/moving_markers.dart
        return  Scaffold(
            body: Center(
                child: SizedBox(
                    child: FlutterMap(
                        options: MapOptions(
                            center: widget._vm.repository.userPosition,
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
                                        point: widget._vm.repository.userPosition,
                                        builder: (ctx) => GestureDetector(
                                            onTap: () {},
                                            child: Icon(Icons.my_location)//const FlutterLogo(),
                                        )
                                    )
                                ]+_getMarkersFromSpot(widget._vm.repository.mapSpotsCache),
                            )
                        ],
                    ),
                ),
            ),
        );
    }
}