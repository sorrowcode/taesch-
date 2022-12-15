import 'package:flutter_map/flutter_map.dart';
import 'package:taesch/api/repositories/osm_repository.dart';
import 'package:taesch/api/repositories/repository_type.dart';
import 'package:taesch/api/repository_holder.dart';
import 'package:taesch/model/shop.dart';

class ShopsMapScreenVM {
  Shop? shop;
  OSMRepository osmRepository = (RepositoryHolder()
      .getRepositoryByType(RepositoryType.osm) as OSMRepository);
  List<Marker> shopsMarker = [];
  int idCounter = 1;
  int lastID = 0;
}
