import 'package:flutter/material.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/log_message.dart';
import 'package:taesch/view/custom_widget/shops_tile.dart';
import 'package:taesch/view/screen/shops_map_screen.dart';
import 'package:taesch/view_model/screen/near_shops_screen_vm.dart';

/// shows the shops which are near to the own location
class NearShopsScreen extends StatefulWidget {
  final _vm = NearShopsScreenVM();

  NearShopsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NearShopsScreenState();
}

class _NearShopsScreenState extends State<NearShopsScreen> {
  LoggerWrapper logger = LoggerWrapper();

  @override
  void initState() {
    super.initState();
    _getCurrentUserPosition();
    widget._vm.osmRepository.osmActions
        .getNearShops(widget._vm.osmRepository.searchRadius,
            widget._vm.osmRepository.userPosition)
        .then((value) => {
              setState(() {
                widget._vm.osmRepository.cache = value;
              })
            });
  }

  void _getCurrentUserPosition() async {
    widget._vm.osmRepository.userPosition =
        await widget._vm.osmRepository.osmActions.getCurrentPosition();
  }

  List<Widget> _getShopList() {
    var shopsList = <Widget>[];
    for (int i = 0; i < widget._vm.osmRepository.cache.length; i++) {
      shopsList.add(ShopsTile(
        title: widget._vm.osmRepository.cache[i].spot.name,
        address: widget._vm.osmRepository.cache[i].spot.street,
        callBack: () {
          logger.log(
              level: LogLevel.info,
              logMessage: LogMessage(
                  message:
                      "Taped On: ${widget._vm.osmRepository.cache[i].spot.name}"));
          setState(() {
            widget._vm.selectedShop = widget._vm.osmRepository.cache[i];
            widget._vm.isMap = true;
          });
        },
      ));
    }
    return shopsList;
  }

  @override
  Widget build(BuildContext context) {
    logger.log(
        level: LogLevel.info,
        logMessage: LogMessage(message: "entered near shops screen"));
    return widget._vm.isMap
        ? ShopsMapScreen.fromNearScreen(widget._vm.selectedShop)
        : Scaffold(
            body: Column(
            children: [
              Expanded(
                  child: ListView(
                children: _getShopList(),
              ))
            ],
          ));
  }
}
