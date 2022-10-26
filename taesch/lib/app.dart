import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:taesch/view/page/login_page.dart';

import 'view_model/app_vm.dart';

/// this class is the root element of the widget tree
///
/// all configuration happens here
class App extends StatefulWidget {
  final _vm = AppVM();

  App({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();

  static _AppState? of(BuildContext context) => context.findAncestorStateOfType<_AppState>();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget._vm.appTitle,
      themeMode: widget._vm.mode,
      darkTheme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF6a687a),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(
                primary: const Color(0xFF2c3d55),
                secondary: const Color(0xFF6a687a),
              )
              .copyWith(
                  secondary: const Color(0xFF6a687a),
                  brightness: Brightness.dark),
          buttonTheme: ButtonThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color(0xFF2c3d55),
              secondary: const Color(0xFF6a687a),
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF2c3d55),
          ),
          textTheme: const TextTheme(
              button: TextStyle(
            color: Colors.white,
            fontSize: 20,
          )),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF2c3d55),
          )),
      theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: const Color(0xFFf5efff),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFF7371FC),
            secondary: const Color(0xFFf5efff),
          ),
          buttonTheme: ButtonThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color(0xFF7371FC),
              secondary: const Color(0xFFa594f9),
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF7371FC),
          ),
          textTheme: const TextTheme(
              button: TextStyle(
            color: Colors.white,
            fontSize: 20,
          )),
          drawerTheme: const DrawerThemeData(
            backgroundColor: Color(0xFFf5efff),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF7371FC),
          )),
      home: const LoginPage(),
    );
  }

  void changeTheme(ThemeMode mode) {
    setState(() {
      widget._vm.mode = mode;
    });
  }
}
