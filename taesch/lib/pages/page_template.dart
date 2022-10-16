import 'package:flutter/material.dart';
import 'package:taesch/pages/i_view_model.dart';

import '../model/screen.dart';

/// template page with the needed structure
abstract class PageTemplate extends StatefulWidget{
  final String title;
  const PageTemplate({super.key, required this.title});
}

abstract class PageTemplateState extends State<PageTemplate> {
  // has to be initialized in the constructor of the states
  late IViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: body(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: Text(Screen.shoppingList.text),
              onTap: () {
                setState(() {
                  Navigator.pushNamed(context, Screen.shoppingList.text);
                });
              },
            ),
            ListTile(
              title: Text(Screen.nearShops.text),
              onTap: () {
                setState(() {
                  Navigator.pushNamed(context, Screen.nearShops.text);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget body();
}