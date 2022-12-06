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

    Geolocator.getServiceStatusStream().listen((ServiceStatus gpsStatus) {
      if (gpsStatus == ServiceStatus.disabled) {
        _isGpsOnline = false;
        notifyListeners();
      } else {
        _isGpsOnline = true;
        notifyListeners();
      }
    });

    connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        _isOnline = false;
        notifyListeners();
      } else {
        _isOnline = true;
        notifyListeners();
      }
    });
  }
}