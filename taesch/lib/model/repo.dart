import 'package:taesch/model/actions.dart';
import 'package:taesch/model/repository_type.dart';

abstract class Repo {
  final Actions actions;
  late final RepositoryType type;

  Repo({required this.actions}) {
    actions.init();
  }
}