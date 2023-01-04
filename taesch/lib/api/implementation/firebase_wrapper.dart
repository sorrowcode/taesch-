import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:taesch/api/actions/firebase_actions.dart';
import 'package:taesch/exceptions/custom/login_exception.dart';
import 'package:taesch/exceptions/custom/registration_exception.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/log_message.dart';

import 'firebase_options.dart';

class FirebaseWrapper implements FirebaseActions {
  LoggerWrapper logger = LoggerWrapper();

  @override
  void init() async {
    logger.log(level: LogLevel.info, logMessage: LogMessage(
      message: "initialized firebase wrapper"
    ));
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }

  @override
  Future<void> login({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (_, e) {
      throw LoginException(cause: "invalid login");
    }
  }

  @override
  Future<void> register(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException {
      throw RegistrationException(cause: "email is already in use");
    }
  }
}
