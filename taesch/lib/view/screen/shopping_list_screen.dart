import 'package:flutter/material.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/log_message.dart';
import 'package:taesch/model/product.dart';
import 'package:taesch/view_model/screen/shopping_list_screen_vm.dart';

/// shows the shopping list elements
class ShoppingListScreen extends StatefulWidget {
  late final ShoppingListScreenVM _vm;

  ShoppingListScreen({super.key, required List<Product> products}) {
    _vm = ShoppingListScreenVM(products: products);
  }

  @override
  State<StatefulWidget> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  LoggerWrapper logger = LoggerWrapper();

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
      itemCount: widget._vm.products.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              logger.log(
                  level: LogLevel.info,
                  logMessage: LogMessage(
                      message:
                          "tapped on ${widget._vm.products[index].name} item"));
              debugPrint('Card tapped.');
            },
            child: Column(children: [
              SizedBox(
                width: 100,
                height: 150,
                child: Center(child: Text(widget._vm.products[index].name)),
              ),
              SizedBox(
                width: 100,
                height: 20,
                child: Text(widget._vm.products[index]
                    .tags.map((e) => e.name).toString()),
              ),
            ])
          ),
        );
      },
    );
  }
}
