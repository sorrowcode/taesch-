import 'package:flutter/material.dart';
import 'package:taesch/logic/theme_controller.dart';
import 'package:taesch/logic/theme_controller_provider.dart';
import 'package:taesch/view/page/login_page.dart';

import 'view_model/app_vm.dart';

/// this class is the root element of the widget tree
///
/// all configuration happens here
class App extends StatefulWidget {
  final _vm = AppVM();
  late final ThemeController _controller;

  App({super.key, required ThemeController controller}) {
    _controller = controller;
  }

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    var a = const Color(0xFF12263A);
    var b = const Color(0xFF06BCC1);
    var c = const Color(0xFFC5D8D1);
    var d = const Color(0xFFF4D1AE);
    var e = const Color(0xFFF4EDEA);
    var f = const Color(0xFF000000);
    return AnimatedBuilder(
      animation: widget._controller,
      builder: (context, _) => ThemeControllerProvider(
        controller: widget._controller,
        child: MaterialApp(
          title: widget._vm.appTitle,
          themeMode: _mode(),
          darkTheme: ThemeData(),
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: e,
            primaryColor: a,
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(d),
              ),
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: c,
              foregroundColor: a,
            ),
            textTheme: TextTheme(
              displayMedium: TextStyle(
                color: a,
              ),
              headlineSmall: TextStyle(
                color: a,
              ),
              titleLarge: TextStyle(
                color: e
              ),
              titleMedium: TextStyle(
                color: a,
              ),
              titleSmall: TextStyle(
                color: a,
              ),
              labelLarge: TextStyle(
                color: a,
              ),
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: a,
              titleTextStyle: Theme.of(context).textTheme.titleLarge,
            ),
            drawerTheme: DrawerThemeData(
              backgroundColor: e,
            ),
            cardColor: d,
            iconTheme: IconThemeData(
              color: a,
            ),
            dialogTheme: DialogTheme(
              backgroundColor: e,
              titleTextStyle: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          home: const LoginPage(),
        ),
      ),
    );
  }

  ThemeMode _mode() {
    return widget._controller.darkTheme ? ThemeMode.dark : ThemeMode.light;
  }
}
