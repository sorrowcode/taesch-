import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taesch/api/repositories/repository_type.dart';
import 'package:taesch/controller/theme_controller.dart';

import 'api/repositories/osm_repository.dart';
import 'api/repository_holder.dart';
import 'app.dart';

/// entry point
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  //(RepositoryHolder().getRepositoryByType(RepositoryType.osm) as OSMRepository)
  //    .startGeoTimer();
  final themeController = ThemeController(prefs);
  runApp(App(
    controller: themeController,
  ));
}
