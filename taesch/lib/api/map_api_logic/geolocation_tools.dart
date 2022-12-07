//import 'package:flutter/material.dart';
import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:taesch/api/repository.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/log_message.dart';

class GeolocationTools {
  Repository repository;
  final int locateTimeout = 20; // <-- measured delay, for precise location
  final int locationTimerPause = 10;
  LoggerWrapper logger = LoggerWrapper();

  GeolocationTools(this.repository);

  Future<void> getCurrentPosition() async {
    if (_geolocatorPermissionIsSet()) {
      // return lat and long
      try {
        // instantiate Future

        Future<Position> positionFuture = Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        positionFuture.timeout(Duration(seconds: locateTimeout));
        //await Future.delayed(Duration(seconds: 5));
        //print("finished sleeping");
        try {
          Position position = await positionFuture;

          // on success locating the user, return the position
          // print("Position: \nlat: "+position.latitude.toString()+"\nlong: "+position.longitude.toString()); // <- log

          // update position in Repository
          repository.setPosition(position);
        } on TimeoutException catch (e) {
          // print("Too long to get location."); // error message
          e.toString();
        }
      } catch (e) {
        // print("Fetching position failed because of:\n"+e.toString());
        e.toString();
      }
    } else {
      // return some default position, or NULL
    }
  }

  bool _geolocatorPermissionIsSet() {
    // check wether Geolocator has the permission
    // work with timeouts
    // Future<LocationPermission> permission = Geolocator.requestPermission();
    return false;
  }

  // might also be a method to be manually called from settings
  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // snackbar
      logger.log(
          level: LogLevel.info,
          logMessage: LogMessage(
              message: "Location services are disabled. Please enable the services.")// <-- maybe show a pop-up
      );
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.denied && permission != LocationPermission.deniedForever) {
        return true;
      } else {
        logger.log(
            level: LogLevel.info,
            logMessage: LogMessage(
                message: "Location permissions are denied.")
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      logger.log(
          level: LogLevel.info,
          logMessage: LogMessage(
              message: "Location permissions are permanently denied, we cannot request permissions.")
      );
      return false;
    }

    logger.log(
        level: LogLevel.info,
        logMessage: LogMessage(
            message: "Geolocator is permitted.")
    );
    return true;
  }

  void startGeoTimer() {
    Timer.periodic(Duration(seconds: locationTimerPause), (timer) async {
      //print(timer.tick);
      await getCurrentPosition();

      // abort condition
      /*if (false) {
        print('Cancel timer');
        timer.cancel();
      }*/
    });
  }
}
