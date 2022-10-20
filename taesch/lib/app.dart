import 'package:flutter/material.dart';
import 'package:taesch/pages/view_model/app_vm.dart';
import 'model/screen.dart';

/// this class is the root element of the widget tree
///
/// all configuration happens here
class App extends StatefulWidget {
  final vm = AppVM();

  App({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taesch!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(widget.vm.screenState.text),
        ),
        body: widget.vm.getCurrentScreen(),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: _setupSideBarElements(),
          ),
        ),
        floatingActionButton: widget.vm.screenState == Screen.shoppingList
            ? FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {},
              )
            : null,
      ),
    );
  }

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
            widget.vm.screenState = page;
            _scaffoldKey.currentState!.closeDrawer();
          });
        },
      ));
    }
    return elements;
  }
}
