import 'package:firebase_core/firebase_core.dart';
import 'package:taesch/api/actions/firebase_actions.dart';

import 'firebase_options.dart';

class FirebaseWrapper implements FirebaseActions {
  @override
  void init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
