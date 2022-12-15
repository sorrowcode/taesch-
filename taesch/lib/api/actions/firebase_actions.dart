import 'package:taesch/api/actions/actions.dart';

abstract class FirebaseActions implements Actions {

  Future<void> login({required String email, required String password});

  Future<void> register({required String email, required String password});
}
