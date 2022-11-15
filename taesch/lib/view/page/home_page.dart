import 'package:flutter/material.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/log_message.dart';
import 'package:taesch/model/screen_state.dart';
import 'package:taesch/view/custom_widget/add_item_dialog.dart';
import 'package:taesch/view/screen/near_shops_screen.dart';
import 'package:taesch/view/screen/settings_screen.dart';
import 'package:taesch/view/screen/shopping_list_screen.dart';
import 'package:taesch/view/screen/shops_map_screen.dart';
import 'package:taesch/view_model/page/home_page_vm.dart';

class HomePage extends StatefulWidget {
  final _vm = HomePageVM();

  HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  LoggerWrapper logger = LoggerWrapper();

  @override
  Widget build(BuildContext context) {
    logger.log(
        level: LogLevel.info,
        logMessage: LogMessage(message: "entered HomePage"));
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
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
          floatingActionButton:
              widget._vm.screenState == ScreenState.shoppingList
                  ? FloatingActionButton(
                      child: const Icon(Icons.add),
                      onPressed: () {
                        logger.log(
                            level: LogLevel.info,
                            logMessage: LogMessage(
                                message:
                                    "floating action button add item pressed"));
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AddItemDialog(),
                        );
                      },
                    )
                  : null,
        ));
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
            logger.log(
                level: LogLevel.info,
                logMessage: LogMessage(
                    message: "tapped on side bar element ${page.text}"));
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
        return ShoppingListScreen();
      case ScreenState.nearShops:
        return NearShopsScreen();
      case ScreenState.settings:
        return SettingsScreen();
      case ScreenState.shopsMap:
        return ShopsMapScreen();
    }
  }
}
