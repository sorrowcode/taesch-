import 'package:flutter/material.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/log_message.dart';
import 'package:taesch/model/product.dart';
import 'package:taesch/model/screen_state.dart';
import 'package:taesch/model/widget_key.dart';
import 'package:taesch/view/custom_widget/add_item_dialog.dart';
import 'package:taesch/view/screen/near_shops_screen.dart';
import 'package:taesch/view/screen/settings_screen.dart';
import 'package:taesch/view/screen/shopping_list_screen.dart';
import 'package:taesch/view/screen/shops_map_screen.dart';
import 'package:taesch/view_model/page/home_page_vm.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  LoggerWrapper logger = LoggerWrapper();
  late Widget screen;
  final _vm = HomePageVM();

  @override
  Widget build(BuildContext context) {
    if (_vm.init) {
      var products = ModalRoute.of(context)?.settings.arguments;
      _vm.init = false;
      screen = products == null
          ? ShoppingListScreen(products: const <Product>[])
          : ShoppingListScreen(products: (products as List<Product>));
    }
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(_vm.screenState.text),
          ),
          body: screen,
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: _setupSideBarElements(),
            ),
          ),
          floatingActionButton: _vm.screenState == ScreenState.shoppingList
              ? FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () async {
                    logger.log(
                        level: LogLevel.info,
                        logMessage: LogMessage(
                            message:
                                "floating action button add item pressed"));
                    var result = await showDialog(
                      context: context,
                      builder: (BuildContext context) => AddItemDialog(),
                    );
                    setState(() {
                      screen = result == null
                          ? ShoppingListScreen(products: const <Product>[])
                          : ShoppingListScreen(products: result);
                    });
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
        key: page == ScreenState.shoppingList
            ? Key(WidgetKey.shoppingListScreenListTile.text)
            : null,
        title: Text(page.text),
        onTap: () {
          logger.log(
              level: LogLevel.info,
              logMessage: LogMessage(
                  message: "tapped on side bar element ${page.text}"));
          setState(() {
            _vm.screenState = page;
            _getCurrentScreen();
          });
          _scaffoldKey.currentState!.closeDrawer();
        },
      ));
    }
    return elements;
  }

  /// sets up screen that changes when a different screen is selected
  void _getCurrentScreen() {
    switch (_vm.screenState) {
      case ScreenState.shoppingList:
        _vm.repository.sqlDatabase.getProductList(true).then((value) {
          screen = ShoppingListScreen(products: value);
        });
        break;
      case ScreenState.nearShops:
        screen = NearShopsScreen();
        break;
      case ScreenState.settings:
        screen = SettingsScreen();
        break;
      case ScreenState.shopsMap:
        screen = ShopsMapScreen();
        break;
    }
  }
}
