import 'package:flutter/material.dart';
import 'package:taesch/pages/view/near_shops_page.dart';

import 'model/screen.dart';
import 'pages/view/shopping_list_page.dart';

/// this class is the root element of the widget tree
///
/// all configuration happens here
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taesch!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        Screen.shoppingList.text: (context) => ShoppingListPage(
              title: Screen.shoppingList.text,
            ),
        Screen.nearShops.text: (context) => NearShopsPage(
              title: Screen.nearShops.text,
            ),
      },
      home: ShoppingListPage(
        title: Screen.shoppingList.text,
      ),
    );
  }
}
