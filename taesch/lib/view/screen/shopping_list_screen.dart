import 'package:flutter/material.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/log_message.dart';
import 'package:taesch/model/product.dart';
import 'package:taesch/view_model/screen/shopping_list_screen_vm.dart';

/// shows the shopping list elements
class ShoppingListScreen extends StatefulWidget {
  late final List<Product> _products;

  ShoppingListScreen({super.key, required List<Product> products}) {
    _products = products;
  }

  @override
  State<StatefulWidget> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  LoggerWrapper logger = LoggerWrapper();
  late final ShoppingListScreenVM _vm;

  _ShoppingListScreenState() {
    _vm = ShoppingListScreenVM(products: widget._products);
  }

  @override
  Widget build(BuildContext context) {
    logger.log(
        level: LogLevel.info,
        logMessage: LogMessage(message: "entered shopping list screen"));
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
      ),
      itemCount: _vm.products.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onLongPress: () {
                logger.log(
                    level: LogLevel.info,
                    logMessage: LogMessage(
                        message: "tapped on ${_vm.products[index].name} item"));
                _vm.repository.sqlDatabase
                    .deleteProduct(true, _vm.products[index].name)
                    .then((value) {
                  setState(() {
                    _vm.products.remove(_vm.products[index]);
                  });
                });
              },
              child: Column(children: [
                SizedBox(
                  width: 100,
                  height: 150,
                  child: Center(child: Text(_vm.products[index].name)),
                ),
                SizedBox(
                  width: 100,
                  height: 20,
                  child: Text(
                      _vm.products[index].tags.map((e) => e.name).toString()),
                ),
              ])),
        );
      },
    );
  }
}
