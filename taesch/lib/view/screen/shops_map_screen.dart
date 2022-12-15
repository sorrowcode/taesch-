import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/log_message.dart';
import 'package:taesch/model/shop.dart';
import 'package:taesch/model/widget_key.dart';
import 'package:taesch/view/custom_widget/marker_long_tap_dialog.dart';
import 'package:taesch/view_model/screen/shops_map_screen_vm.dart';

class ShopsMapScreen extends StatefulWidget {
  final _vm = ShopsMapScreenVM();

  ShopsMapScreen({super.key}) {
    _vm.shop = null;
  }

  ShopsMapScreen.fromNearScreen(Shop selectedShop, {super.key}) {
    _vm.shop = selectedShop;
  }

  @override
  State<StatefulWidget> createState() => _ShopsMapScreenState();
}

class _ShopsMapScreenState extends State<ShopsMapScreen> {
  LoggerWrapper logger = LoggerWrapper();

  @override
  void initState() {
    setState(() {
      widget._vm.shopsMarker.add(Marker(
          point: LatLng(widget._vm.osmRepository.userPosition.latitude,
              widget._vm.osmRepository.userPosition.longitude),
          builder: (ctx) => GestureDetector(
              onTap: () {},
              child: const Icon(Icons.my_location_outlined,
                  shadows: [
                    BoxShadow(
                      blurRadius: 20.0,
                      color: Colors.blue,
                    ),
                  ],
                  size: 30,
                  color: Colors.blue) //const FlutterLogo(),
              )));
      if (widget._vm.shop == null) {
        for (Shop shop in widget._vm.osmRepository.cache) {
          int id = widget._vm.idCounter;
          widget._vm.shopsMarker.add(Marker(
              point: LatLng(shop.mapSpot.lat, shop.mapSpot.long),
              builder: (ctx) => GestureDetector(
                    onLongPress: () {
                      if (widget._vm.lastID != 0) {
                        setBlack(widget._vm.lastID, widget._vm.lastShop);
                      }
                      setRed(id, shop);
                      widget._vm.lastShop = shop;
                      widget._vm.lastID = id;
                      var dialog = MarkerLongTapDialog();
                      dialog.showPupUpDialog(context, shop);
                    },
                    onTap: () {
                      /*ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
                                content: Text('Tapped on blue FlutterLogo Marker'),
                                )
                            );*/
                      print("Tapped on marker $id");
                      if (widget._vm.lastID != 0) {
                        setBlack(widget._vm.lastID, widget._vm.lastShop);
                      }
                      setRed(id, shop);
                      setState(() {
                        widget._vm.lastID = id;
                        widget._vm.lastShop = shop;
                      });
                    },
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.black54,
                    ),
                  )));
          widget._vm.idCounter++;
        }
      } else {
        widget._vm.shopsMarker.add(Marker(
            key: Key(WidgetKey.redMarkerKey.text),
            point: LatLng(
                widget._vm.shop!.mapSpot.lat, widget._vm.shop!.mapSpot.long),
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
            builder: (ctx) =>
                const Icon(Icons.location_on, color: Colors.red)));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logger.log(
        level: LogLevel.info,
        logMessage: LogMessage(message: "entered shops map screen"));
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: FlutterMap(
            options: MapOptions(
              center: widget._vm.shop == null
                  ? LatLng(widget._vm.osmRepository.userPosition.latitude,
                      widget._vm.osmRepository.userPosition.longitude)
                  : LatLng(widget._vm.shop!.mapSpot.lat,
                      widget._vm.shop!.mapSpot.long),
              zoom: 13,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
              ),
              MarkerLayer(
                markers: widget._vm.shopsMarker,
              )
            ],
          ),
        ),
      ),
    );
  }

  void setBlack(int id, Shop shop) {
    setState(() {
      Marker temp = widget._vm.shopsMarker.elementAt(id);
      widget._vm.shopsMarker.removeAt(id);
      widget._vm.shopsMarker.insert(
          id,
          Marker(
              point: LatLng(temp.point.latitude, temp.point.longitude),
              builder: (ctx) => GestureDetector(
                onLongPress: () {
                  setBlack(widget._vm.lastID, widget._vm.lastShop);
                  setRed(id, shop);
                  widget._vm.lastID = id;
                  widget._vm.lastShop = shop;
                  var dialog = MarkerLongTapDialog();
                  dialog.showPupUpDialog(context, shop);
                },
                    onTap: () {
                      /*ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
                                content: Text('Tapped on blue FlutterLogo Marker'),
                                )
                            );*/
                      print("Tapped on marker $id");
                      setBlack(widget._vm.lastID, widget._vm.lastShop);
                      setRed(id, shop);
                      widget._vm.lastID = id;
                      widget._vm.lastShop = shop;
                    },
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.black54,
                    ),
                  )));
    });
  }

  void setRed(int id, Shop shop) {
    setState(() {
      Marker temp = widget._vm.shopsMarker.elementAt(id);
      widget._vm.shopsMarker.removeAt(id);
      widget._vm.shopsMarker.insert(
          id,
          Marker(
              point: LatLng(temp.point.latitude, temp.point.longitude),
              builder: (ctx) => GestureDetector(
                    onLongPress: () {
                      setBlack(widget._vm.lastID, widget._vm.lastShop);
                      setRed(id, shop);
                      widget._vm.lastID = id;
                      widget._vm.lastShop = shop;
                      var dialog = MarkerLongTapDialog();
                      dialog.showPupUpDialog(context, shop);
                    },
                    onTap: () {
                      /*ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
                                content: Text('Tapped on blue FlutterLogo Marker'),
                                )
                            );*/
                      print("Tapped on marker $id");

                      setBlack(widget._vm.lastID, widget._vm.lastShop);
                      setRed(id, shop);
                      widget._vm.lastShop = shop;
                      widget._vm.lastID = id;
                    },
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                  )));
    });
  }
}
