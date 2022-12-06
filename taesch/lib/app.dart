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
    var a = const Color(0xFF8672A5);
    var b = const Color(0xFFFFFFFF);
    var c = const Color(0xFFEEB1B1);
    var d = const Color(0xFFD1C2D9);
    var e = const Color(0xFF515389);
    var f = const Color(0xFF545454);
    var g = const Color(0xFFD6356A);
    return AnimatedBuilder(
      animation: widget._controller,
      builder: (context, _) => ThemeControllerProvider(
        controller: widget._controller,
        child: MaterialApp(
          title: widget._vm.appTitle,
          themeMode: _mode(),
          darkTheme: ThemeData(),
          theme: ThemeData(),
          home: const LoginPage(),
        ),
      ),
    );
  }

  ThemeMode _mode() {
    return widget._controller.darkTheme ? ThemeMode.dark : ThemeMode.light;
  }
}
