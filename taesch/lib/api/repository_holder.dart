import 'dart:collection';

import 'package:taesch/api/repositories/sql_repository.dart';
import 'package:taesch/api/sql/sql_database.dart';
import 'package:taesch/model/repo.dart';
import 'package:taesch/model/repository_type.dart';

class RepositoryHolder {
  late final HashMap<RepositoryType, Repo> _repositories;

  static final RepositoryHolder _singleton = RepositoryHolder._internal();

  factory RepositoryHolder() {
    return _singleton;
  }

  RepositoryHolder._internal() {
    for (RepositoryType type in RepositoryType.values) {
      switch(type) {
        case RepositoryType.sql:
          _repositories[type] = SQLRepository(actions: SQLDatabase());
          break;
        case RepositoryType.osm:
          _repositories[type] = SQLRepository(actions: SQLDatabase()); //todo adjust
          break;
        case RepositoryType.firebase:
          _repositories[type] = SQLRepository(actions: SQLDatabase()); //todo adjust
          break;
      }
    }
  }
  
  Repo? getRepositoryByType(RepositoryType type) {
    return _repositories[type];
  }
}