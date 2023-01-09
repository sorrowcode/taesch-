import 'package:geolocator/geolocator.dart';
import 'package:taesch/api/actions/actions.dart';
import 'package:taesch/model/shop.dart';

abstract class OSMActions implements Actions {

  Future<List<Shop>> getNearShops(int searchRadius, Position position);

  Future<Position> getCurrentPosition();

  Future<void> handleLocationPermission();

  bool geolocationServicesEnabled();

  bool geoLocationPermissionGranted();

  bool geoLocationPermissionIsPermanentlyDenied();

  void denyGeoLocationPermission();

}
