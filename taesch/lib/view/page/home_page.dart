import 'package:flutter/material.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/model/screen_state.dart';
import 'package:taesch/view/screen/near_shops_screen.dart';
import 'package:taesch/view/screen/settings_screen.dart';
import 'package:taesch/view/screen/shopping_list_screen.dart';
import 'package:taesch/view_model/home_page_vm.dart';

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
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      _popupDialogCreateShoppingItem(context),
                );
              },
            )
          : null,
    );
  }

  Widget _popupDialogCreateShoppingItem(BuildContext context) {
    return AlertDialog(
        title: const Text('Add Item to Shopping List'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                validator: (value) {
                  return widget._vm.validateShoppingListItem(value)?.message;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter Item'))
          ],
        ),
        actions: <Widget>[
          TextButton(
              child: const Icon(Icons.check),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          TextButton(
            child: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ]);
  }

  List<Widget> _setupSideBarElements() {
    var elements = <Widget>[];
    elements.add(DrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
      ),
      child: const Text(''),
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
