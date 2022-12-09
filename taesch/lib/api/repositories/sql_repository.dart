import 'package:taesch/api/actions/sql_actions.dart';
import 'package:taesch/api/repositories/repository_type.dart';
import 'package:taesch/exceptions/custom/type_exception.dart';
import 'package:taesch/api/repositories/repo.dart';

class SQLRepository extends Repo {
  SQLRepository({required SQLActions super.actions}) {
    type = RepositoryType.sql;
  }

  SQLActions get sqlActions => actions as SQLActions;
}
