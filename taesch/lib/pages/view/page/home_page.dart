import 'package:flutter/material.dart';
import 'package:taesch/model/screen_state.dart';
import 'package:taesch/pages/view/screen/near_shops_screen.dart';
import 'package:taesch/pages/view/screen/settings_screen.dart';
import 'package:taesch/pages/view/screen/shopping_list_screen.dart';
import 'package:taesch/pages/view_model/home_page_vm.dart';

class HomePage extends StatefulWidget {
  final _vm = HomePageVM();

  HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
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
              backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
              onPressed: () {},
            )
          : null,
    );
  }

  List<Widget> _setupSideBarElements() {
    var elements = <Widget>[];
    elements.add( DrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,

      ),
      child: Text(''),
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
        return SettingsScreen();
    }
  }
}
