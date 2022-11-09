
//import 'package:flutter/material.dart';
import 'dart:async';

import 'package:geolocator/geolocator.dart';

class GeolocationTools{

  final int locateTimeout = 20; // <-- measured delay, for precise location
  final int locationTimerPause = 10;

  Future<void> getCurrentPosition() async{
    if(_geolocatorPermissionIsSet()){
      // return lat and long
      try {
        // instantiate Future

        Future<Position> positionFuture = Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        positionFuture.timeout(Duration(seconds: locateTimeout));
        //await Future.delayed(Duration(seconds: 5));
        //print("finished sleeping");
        try{
          Position position = await positionFuture;

          // on success locating the user, return the position
          print("Position: \nlat: "+position.latitude.toString()+"\nlong: "+position.longitude.toString());

        }on TimeoutException catch(e){
          print("Too long to get location."); // error message
        }
      }catch(e){
        print("Fetching position failed because of:\n"+e.toString());
      }
    }else{
      // return some default position, or NULL
    }
  }

  bool _geolocatorPermissionIsSet(){
    // check wether Geolocator has the permission
    // work with timeouts
    Future<LocationPermission> permission = Geolocator.requestPermission();
    return true;
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // snackbar
      print('Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      print('Location permissions are denied');
        return false;
      }
    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    print("geolocator permitted.");
    return true;
  }

  void startGeoTimer(){
    Timer.periodic(Duration(seconds: locationTimerPause), (timer) async {
      print(timer.tick);
      await getCurrentPosition();
      if (false) {
        print('Cancel timer');
        timer.cancel();
      }
    });
  }

}