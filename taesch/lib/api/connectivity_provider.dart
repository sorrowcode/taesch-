import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class ConnectivityProvider with ChangeNotifier {
  late bool _isOnline;
  bool get isOnline => _isOnline;

  late bool _isGpsOnline;
  bool get isGpsOnline => _isGpsOnline;

  ConnectivityProvider() {
    Connectivity connectivity = Connectivity();
    _isOnline = false;
    _isGpsOnline = false;


    Geolocator.getServiceStatusStream().listen((ServiceStatus gpsStatus) {
      if (gpsStatus == ServiceStatus.disabled) {
        _isGpsOnline = false;
      } else {
        _isGpsOnline = true;
      }
      notifyListeners();
    });
    connectivity.checkConnectivity().then((result) {// init
      _isOnline = _connectivityCheck(result);
      notifyListeners();
    });
    connectivity.onConnectivityChanged.listen((result) {// change
      _isOnline = _connectivityCheck(result);
      notifyListeners();
    });
  }
  bool _connectivityCheck(result){
    if (result == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}