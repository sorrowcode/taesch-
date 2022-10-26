import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:taesch/model/shopping_list_item.dart';


/// shows the shopping list elements
class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  List<ShoppingListItem> itemList = [];

  @override
  void initState() async {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
      ),
      itemCount: itemList.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              debugPrint('Card tapped.');
            },
            child: SizedBox(
              width: 100,
              height: 100,
              child: Center(child: Text(itemList[index].title)),
            ),
          ),
        );
      },
    );
  }
}
