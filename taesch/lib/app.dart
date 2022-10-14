import 'package:flutter/material.dart';

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
      home: ShoppingListPage(title: 'Shopping List'),
    );
  }
}
