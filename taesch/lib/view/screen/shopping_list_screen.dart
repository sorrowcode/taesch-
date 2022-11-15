import 'package:flutter/material.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/log_message.dart';
import 'package:taesch/view_model/screen/shopping_list_screen_vm.dart';

/// shows the shopping list elements
class ShoppingListScreen extends StatefulWidget {
  final ShoppingListScreenVM _vm = ShoppingListScreenVM();

  ShoppingListScreen({super.key});

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
    return ValueListenableBuilder<int>(
        valueListenable: widget._vm.repository.shoppingListSize,
        builder: (context, value, child) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
            ),
            itemCount: value,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    logger.log(
                        level: LogLevel.info,
                        logMessage: LogMessage(
                            message:
                                "tapped on ${widget._vm.repository.shoppingListItems[index].title} item"));
                    debugPrint('Card tapped.');
                  },
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Center(
                        child: Text(widget
                            ._vm.repository.shoppingListItems[index].title)),
                  ),
                ),
              );
            },
          );
        });
  }
}
