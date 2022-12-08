import 'package:taesch/api/actions/osm_actions.dart';
import 'package:taesch/exceptions/custom/type_exception.dart';
import 'package:taesch/model/repo.dart';
import 'package:taesch/model/repository_type.dart';

class OSMRepository extends Repo {
  OSMRepository({required super.actions}) {
    type = RepositoryType.osm;
    if (actions is !OSMActions) {
      throw TypeException(cause: "initialized to wrong type");
    }
  }

  OSMActions get osmActions => actions as OSMActions;
}