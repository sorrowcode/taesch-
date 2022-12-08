import 'package:taesch/api/actions/firebase_actions.dart';
import 'package:taesch/exceptions/custom/type_exception.dart';
import 'package:taesch/api/repositories/repo.dart';

import 'repository_type.dart';

class FirebaseRepository extends Repo {
  FirebaseRepository({required super.actions}) {
    type = RepositoryType.firebase;
    if (actions is! FirebaseActions) {
      throw TypeException(cause: "initialized to wrong type");
    }
  }

  FirebaseActions get sqlActions => actions as FirebaseActions;
}
