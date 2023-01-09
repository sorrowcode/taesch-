import 'package:taesch/api/repositories/osm_repository.dart';

import '../../api/repositories/repository_type.dart';
import '../../api/repository_holder.dart';

class SettingsScreenVM {
  String switchTitle = 'Dark Mode';
  String radTitle = 'Supermarket Search Radius';

  List<int> radValues = [500,1000,3000,5000,10000];

  OSMRepository repo = RepositoryHolder().getRepositoryByType(RepositoryType.osm) as OSMRepository;
}
