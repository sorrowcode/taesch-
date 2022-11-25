import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taesch/api/repository.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/log_message.dart';

import 'home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  LoggerWrapper logger = LoggerWrapper();
  Repository repository = Repository();

  @override
  void initState() {
    setState(() {
      repository.sqlDatabase.init().then((value) {
        repository.geolocationTools.startGeoTimer();
        repository.sqlDatabase.getProductList(true).then((value) {
          Timer(const Duration(seconds: 3), () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HomePage(),
                settings: RouteSettings(arguments: value)));
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logger.log(
        level: LogLevel.info,
        logMessage: LogMessage(message: "entered splash page"));
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 50),
          child: Image.asset("assets/logo.png"),
        ),
      ),
    );
  }
}
