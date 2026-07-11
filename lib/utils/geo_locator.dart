import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class GeoLocation {
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    PermissionStatus permission;
    //
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Permission.location.status;
    if (permission == PermissionStatus.denied) {
      permission = await Permission.location.request();
      if (permission == PermissionStatus.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == PermissionStatus.permanentlyDenied) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = Position(
        longitude: 00.00,
        latitude: 00.00,
        timestamp: DateTime.now(),
        accuracy: 00.00,
        altitude: 00.00,
        altitudeAccuracy: 00.00,
        heading: 00.00,
        headingAccuracy: 00.00,
        speed: 00.00,
        speedAccuracy: 00.00);
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return position;
  }
}
