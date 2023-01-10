import 'package:taesch/api/repositories/osm_repository.dart';
import 'package:taesch/api/repositories/repository_type.dart';
import 'package:taesch/api/repository_holder.dart';

class SettingsScreenVM {
  String switchTitle = 'Dark Mode';
  String permissionSwitchTitle = 'Allow Location';
  String radTitle = 'Supermarket Search Radius';

  List<int> radValues = [500,1000,3000,5000,10000];

  OSMRepository repo = RepositoryHolder().getRepositoryByType(RepositoryType.osm) as OSMRepository;
}
