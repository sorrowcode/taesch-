
//import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:ui';

import 'package:geolocator/geolocator.dart';

class GeolocationTools{

  static const locateTimeout = 20; // <-- measured delay, for precise location

  static void getCurrentPosition() async{
    if(_geolocatorPermissionIsSet()){
      // return lat and long
      try {
        print("jknsdkjsdnjkdnfjkfnjkfnselkdjfn555558585858558");
        // instantiate Future

        Future<Position> positionFuture = Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        print("333333333dodioidofidofidf");
        positionFuture.timeout(const Duration(seconds: locateTimeout));
        print("11111111111YYYYYYYYYYYYYY99999999999999999");
        //sleep(const Duration(seconds: 5)); // if not called in an isolate, this stops the main thread
        try{
          Position position = await positionFuture;

          /*Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high).timeout(const Duration(seconds: locateTimeout));
           */

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

  static bool _geolocatorPermissionIsSet(){
    // check wether Geolocator has the permission
    // work with timeouts
    Future<LocationPermission> permission = Geolocator.requestPermission();
    return true;
  }

  static Future<bool> handleLocationPermission() async {
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

}