import 'package:taesch/api/actions/firebase_actions.dart';
import 'package:taesch/api/repositories/repository.dart';

import 'repository_type.dart';

class FirebaseRepository extends Repo {
  FirebaseRepository({required FirebaseActions super.actions}) {
    type = RepositoryType.firebase;
  }

  FirebaseActions get firebaseActions => actions as FirebaseActions;
}
