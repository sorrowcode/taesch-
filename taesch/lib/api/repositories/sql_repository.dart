import 'package:taesch/api/actions/sql_actions.dart';
import 'package:taesch/api/repositories/repository.dart';
import 'package:taesch/api/repositories/repository_type.dart';

class SQLRepository extends Repo {
  SQLRepository({required SQLActions super.actions}) {
    type = RepositoryType.sql;
  }

  SQLActions get sqlActions => actions as SQLActions;
}
