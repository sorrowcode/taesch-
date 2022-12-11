import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taesch/view_model/screen/shopping_list_templates_screen_vm.dart';

import '../../middleware/log/log_level.dart';
import '../../middleware/log/logger_wrapper.dart';
import '../../model/log_message.dart';
import '../../model/product.dart';

class ShoppingListTemplatesScreen extends StatefulWidget {
  late final ShoppingListTemplatesScreenVM _vm;

  ShoppingListTemplatesScreen({super.key, required List<Product> products}) {
    _vm = ShoppingListTemplatesScreenVM(products: products);
  }

  @override
  State<StatefulWidget> createState() => _ShoppingListTemplatesScreenState();
}

class _ShoppingListTemplatesScreenState extends State<ShoppingListTemplatesScreen> {

  LoggerWrapper logger = LoggerWrapper();

  @override
  Widget build(BuildContext context) {
    logger.log(
        level: LogLevel.info,
        logMessage: LogMessage(message: "entered shopping list templates screen"));
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
      ),
      itemCount: widget._vm.products.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onLongPress: () {
                logger.log(
                    level: LogLevel.info,
                    logMessage: LogMessage(
                        message:
                        "tapped on ${widget._vm.products[index].name} item"));
                widget._vm.sqlRepository.sqlActions
                    .deleteProduct(true, widget._vm.products[index].name)
                    .then((value) {
                  setState(() {
                    widget._vm.products.remove(widget._vm.products[index]);
                  });
                });
              },
              child: Column(children: [
                SizedBox(
                  width: 100,
                  height: 125,
                  child: Center(
                      child: Text(
                        widget._vm.products[index].name,
                        style: const TextStyle(fontSize: 25),
                      )),
                ),
                SizedBox(
                  width: 100,
                  height: 50,
                  child: Text(
                    widget._vm.products[index].tags
                        .map((e) => e.name)
                        .join(' , ')
                        .replaceAll('[', '')
                        .replaceAll(']', ''),
                    textAlign: TextAlign.center,
                  ),
                ),
              ])),
        );
      },
    );
  }
}