import 'package:taesch/api/actions/actions.dart';
import 'package:taesch/api/repositories/repository_type.dart';

abstract class Repo {
  final Actions actions;
  late final RepositoryType type;

  Repo({required this.actions}) {
    actions.init();
  }
}
