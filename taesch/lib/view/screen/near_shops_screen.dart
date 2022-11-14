import 'package:flutter/material.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/log_message.dart';
import 'package:taesch/view/custom_widget/shops_tile.dart';
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

  List<Widget> _getShopList() {
    widget._vm.loadShops();
    var shopsList = <Widget>[];
    for (int i = 0; i < widget._vm.repository.shopsCache.length; i++) {
      shopsList.add(ShopsTile(
          title: widget._vm.repository.shopsCache[i].name,
          address: widget._vm.repository.shopsCache[i].address));
    }
    return shopsList;
  }

  @override
  Widget build(BuildContext context) {
    //widget._vm.getShops();
    logger.log(level: LogLevel.info, logMessage: LogMessage(
        message: "entered near shops screen"
    ));
    return Scaffold(
        body: Column(
      children: [
        Center(
          child: SizedBox(
            height: 100,
            child: Column(
              children: [
                const Text("Area: Heilbronn", style: TextStyle(fontSize: 25)),
                TextButton(
                  child: const Text("Search"),
                  onPressed: () {
                    logger.log(level: LogLevel.info, logMessage: LogMessage(
                        message: "search button pressed"
                    ));
                    setState(() {
                      widget._vm.loadShops();
                    });
                  },
                )
              ],
            ),
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
          child: ValueListenableBuilder<int>(
              valueListenable: widget._vm.repository.shopsCacheSize,
              child: Column(
                children: _getShopList(),
              ),
              builder: (context, value, child) {
                return Column(
                  children: _getShopList(),
                );
              }),
        ))
      ],
    ));
  }
}
