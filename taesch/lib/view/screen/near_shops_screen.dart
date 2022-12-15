import 'package:flutter/material.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/log_message.dart';
import 'package:taesch/model/widget_key.dart';
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

  List<Widget> _getShopList() {
    var shopsList = <Widget>[];
    shopsList.add(Center(
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.30,
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                onChanged: (value) {
                  //Do something with the user input.
                },
                initialValue: "Heilbronn",
                decoration: const InputDecoration(
                  hintText: 'Enter a city',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFcdc1ff), width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFcdc1ff), width: 3.0),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                ),
              ),
            ),
            TextButton(
              key: Key(WidgetKey.searchButtonKey.text),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(10)),
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).secondaryHeaderColor),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ))),
              onPressed: () {
                logger.log(
                    level: LogLevel.info,
                    logMessage: LogMessage(message: "search button pressed"));
                widget._vm.osmRepository.osmActions
                    .getNearShops(2000, widget._vm.osmRepository.userPosition)
                    .then((value) {
                  setState(() {
                    widget._vm.osmRepository.cache = value;
                  });
                });
              },
              child: Text(
                "Search",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            )
          ],
        ),
      ),
    ));
    for (int i = 0; i < widget._vm.osmRepository.cache.length; i++) {
      shopsList.add(ShopsTile(
        title: widget._vm.osmRepository.cache[i].name,
        address: widget._vm.osmRepository.cache[i].address,
        callBack: () {
          logger.log(
              level: LogLevel.info,
              logMessage: LogMessage(
                  message:
                      "Taped On: ${widget._vm.osmRepository.cache[i].name}"));
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
