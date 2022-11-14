import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taesch/api/repository.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';

import 'home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  LoggerWrapper logger = LoggerWrapper();

  @override
  void initState() {
    Repository().geolocationTools.startGeoTimer();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logger.log(level: LogLevel.debug, message: "entered splash page");
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
