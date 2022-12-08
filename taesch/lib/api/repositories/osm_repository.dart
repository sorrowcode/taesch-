import 'package:taesch/api/actions/osm_actions.dart';
import 'package:taesch/api/repositories/repository_type.dart';
import 'package:taesch/exceptions/custom/type_exception.dart';
import 'package:taesch/api/repositories/repo.dart';

class OSMRepository extends Repo {
  OSMRepository({required super.actions}) {
    type = RepositoryType.osm;
    if (actions is! OSMActions) {
      throw TypeException(cause: "initialized to wrong type");
    }
  }

  OSMActions get osmActions => actions as OSMActions;
}
