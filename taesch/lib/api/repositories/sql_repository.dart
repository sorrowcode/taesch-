import 'package:taesch/api/definitions/sql_actions.dart';
import 'package:taesch/exceptions/custom/type_exception.dart';
import 'package:taesch/model/repo.dart';
import 'package:taesch/model/repository_type.dart';

class SQLRepository extends Repo {

  SQLRepository({required super.actions}) {
    type = RepositoryType.sql;
    if (actions is !SQLActions) {
      throw TypeException(cause: "initialized to wrong type");
    }
  }

  SQLActions get sqlActions => actions as SQLActions;
}