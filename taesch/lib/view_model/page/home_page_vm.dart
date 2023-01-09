import 'package:taesch/api/repositories/osm_repository.dart';
import 'package:taesch/api/repositories/repository_type.dart';
import 'package:taesch/api/repositories/sql_repository.dart';
import 'package:taesch/api/repository_holder.dart';
import 'package:taesch/model/screen_state.dart';

class HomePageVM {
  late ScreenState screenState = ScreenState.shoppingList;
  bool init = true;
  SQLRepository sqlRepository = (RepositoryHolder()
      .getRepositoryByType(RepositoryType.sql) as SQLRepository);
  OSMRepository osmRepository = (RepositoryHolder()
      .getRepositoryByType(RepositoryType.osm) as OSMRepository);
}
