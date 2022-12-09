import 'package:geolocator/geolocator.dart';
import 'package:taesch/api/actions/osm_actions.dart';
import 'package:taesch/api/repositories/repository_type.dart';
import 'package:taesch/exceptions/custom/type_exception.dart';
import 'package:taesch/api/repositories/repo.dart';

class OSMRepository extends Repo {

  late Position _userPosition;

  OSMRepository({required OSMActions super.actions}) {
    type = RepositoryType.osm;
  }

  OSMActions get osmActions => actions as OSMActions;

  //Position get userPosition => _userPosition.;

  set userPosition(Position position) {
    _userPosition = position;
    //queries.setCustomLocation(LatLng(position.latitude, position.longitude)); todo
  }
}
