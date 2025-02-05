// For debugPrint
import 'package:geolocator/geolocator.dart';

class LocationTracker {
  // Check if location services are enabled
  Future<bool> isLocationEnabled() async {
    bool isEnabled = await Geolocator.isLocationServiceEnabled();
    return isEnabled;
  }

  // Get the current location
  Future<Position> getCurrentLocation() async {
    bool hasPermission = await _checkLocationPermissions();
    if (!hasPermission) {
      throw Exception("Location permissions denied");
    }

    Position position = await Geolocator.getCurrentPosition(
    );
    return position;
  }

  // Check and request location permissions
  Future<bool> _checkLocationPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    return true;
  }
}