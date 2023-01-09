import 'package:geolocator/geolocator.dart';
import 'package:taesch/api/actions/actions.dart';
import 'package:taesch/api/repositories/osm_repository.dart';
import 'package:taesch/model/shop.dart';

abstract class OSMActions implements Actions {
  OSMRepository? osmRepository;

  Future<List<Shop>> getNearShops(int searchRadius, Position position);

  Future<Position> getCurrentPosition();

  Future<void> handleLocationPermission();

  void assignOSMRepository(OSMRepository repository);
}
