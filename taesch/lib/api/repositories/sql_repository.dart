import 'package:taesch/api/actions/sql_actions.dart';
import 'package:taesch/api/repositories/repository_type.dart';
import 'package:taesch/exceptions/custom/type_exception.dart';
import 'package:taesch/api/repositories/repo.dart';

class SQLRepository extends Repo {
  SQLRepository({required super.actions}) {
    type = RepositoryType.sql;
    if (actions is! SQLActions) {
      throw TypeException(cause: "initialized to wrong type");
    }
  }

  SQLActions get sqlActions => actions as SQLActions;
}
