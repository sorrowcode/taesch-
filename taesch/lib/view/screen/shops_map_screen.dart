import 'package:flutter/material.dart';
import 'package:taesch/view_model/screen/shops_map_screen_vm.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ShopsMapScreen extends StatefulWidget{
    final _vm = ShopsMapScreenVM();

    ShopsMapScreen({super.key});

    @override
    State<StatefulWidget> createState() => _ShopsMapScreenState();
}

class _ShopsMapScreenState extends State<ShopsMapScreen>{
    @override
    Widget build(BuildContext context) {

        // taken from the example code of https://github.com/fleaflet/flutter_map/blob/master/example/lib/pages/moving_markers.dart
        return  Scaffold(
            body: Center(
                child: SizedBox(
                    child: FlutterMap(
                        options: MapOptions(
                            center: LatLng(45.5231, -122.6765),
                            zoom: 13,
                        ),
                        children: [
                            TileLayer(
                                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}