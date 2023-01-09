import 'package:taesch/api/actions/ping_actions.dart';
import 'package:taesch/api/repositories/repository.dart';
import 'package:taesch/api/repositories/repository_type.dart';

class PingRepository extends Repo {
  PingRepository({required super.actions}) {
    type = RepositoryType.ping;
  }

  PingActions get pingActions => actions as PingActions;
}