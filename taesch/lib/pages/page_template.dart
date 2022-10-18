import 'package:flutter/material.dart';
import 'package:taesch/app.dart';
import 'package:taesch/pages/i_view_model.dart';

import '../model/screen.dart';

/// template page with the needed structure
abstract class PageTemplate extends StatefulWidget {
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
          children: _setupSideBarElements(),
        ),
      ),
    );
  }

  /// general setup for the side bar
  ///
  /// in case of an exception check the routes in [App]
  List<Widget> _setupSideBarElements() {
    var elements = <Widget>[];
    elements.add(const DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Text('Drawer Header'),
    ));
    for (var page in Screen.values) {
      elements.add(ListTile(
        title: Text(page.text),
        onTap: () {
          setState(() {
            Navigator.pushNamed(context, page.text);
          });
        },
      ));
    }
    return elements;
  }

  Widget body();
}
