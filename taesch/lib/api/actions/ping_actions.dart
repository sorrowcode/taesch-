

import 'package:taesch/api/actions/actions.dart';

abstract class PingActions implements Actions {

  Future<bool> isOnline();

}