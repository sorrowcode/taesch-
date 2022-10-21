import 'package:flutter/material.dart';
import 'package:taesch/pages/view/screen/near_shops_screen.dart';
import 'package:taesch/pages/view/screen/settings_screen.dart';
import 'package:taesch/pages/view/screen/shopping_list_screen.dart';
import 'package:taesch/pages/view_model/app_vm.dart';
import 'model/screen_state.dart';

/// this class is the root element of the widget tree
///
/// all configuration happens here
class App extends StatefulWidget {
  final _vm = AppVM();

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
          title: Text(widget._vm.screenState.text),
        ),
        body: _getCurrentScreen(),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: _setupSideBarElements(),
          ),
        ),
        floatingActionButton: widget._vm.screenState == ScreenState.shoppingList
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
    for (var page in ScreenState.values) {
      elements.add(ListTile(
        title: Text(page.text),
        onTap: () {
          setState(() {
            widget._vm.screenState = page;
            _scaffoldKey.currentState!.closeDrawer();
          });
        },
      ));
    }
    return elements;
  }

  /// sets up screen that changes when a different screen is selected
  Widget _getCurrentScreen() {
    switch (widget._vm.screenState) {
      case ScreenState.shoppingList:
        return const ShoppingListScreen();
      case ScreenState.nearShops:
        return const NearShopsScreen();
      case ScreenState.settings:
        return const SettingsScreen();
    }
  }
}
