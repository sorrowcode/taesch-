import 'package:flutter/material.dart';
import 'package:taesch/pages/view/page/login_page.dart';
import 'package:taesch/pages/view_model/app_vm.dart';

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget._vm.appTitle,
      theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: Color(0xFFf5efff),
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

          )),
      home: const LoginPage(),
    );
  }
}
