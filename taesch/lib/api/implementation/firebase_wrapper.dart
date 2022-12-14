import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:taesch/api/actions/firebase_actions.dart';

import 'firebase_options.dart';

class FirebaseWrapper implements FirebaseActions {
  @override
  void init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }

  @override
  Future<void> login({required String email, required String password}) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }
}
