import 'dart:collection';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:taesch/api/implementation/sql_database.dart';
import 'package:taesch/api/repositories/firebase_repository.dart';
import 'package:taesch/api/repositories/osm_repository.dart';
import 'package:taesch/api/repositories/sql_repository.dart';
import 'package:taesch/api/repositories/repo.dart';

import 'implementation/firebase_wrapper.dart';
import 'implementation/osm.dart';
import 'repositories/repository_type.dart';

class RepositoryHolder {
  late final HashMap<RepositoryType, Repo> _repositories;
  bool _isDarkModeEnabled = false;

  static final RepositoryHolder _singleton = RepositoryHolder._internal();

  factory RepositoryHolder() {
    return _singleton;
  }

  RepositoryHolder._internal() {
    _repositories = HashMap();
    SharedPreferences.getInstance().then((prefs) => _isDarkModeEnabled =
    prefs.containsKey('dark_mode_enabled')
        ? prefs.getBool('dark_mode_enabled')!
        : false);

    for (RepositoryType type in RepositoryType.values) {
      switch (type) {
        case RepositoryType.sql:
          _repositories[type] = SQLRepository(actions: SQLDatabase());
          break;
        case RepositoryType.osm:
          _repositories[type] =
              OSMRepository(actions: OSM());
          break;
        case RepositoryType.firebase:
          _repositories[type] =
              FirebaseRepository(actions: FirebaseWrapper());
          break;
      }
    }
  }

  Repo? getRepositoryByType(RepositoryType type) {
    return _repositories[type];
  }
}
