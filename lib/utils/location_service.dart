import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  Future<bool> checkAndRequestLocationService() async {
    var isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        return false;
      }
    }
    return true;
  }

  Future<bool> checkAndRequestLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      return false;
    }
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  /// ⬅️ الميثود الجديدة
  Future<LocationData?> getCurrentLocation() async {
    try {
      return await location.getLocation();
    } catch (e) {
      return null;
    }
  }

  /// للستريم لو عايز realtime
  void getRealTimeLocationData(void Function(LocationData)? onData) {
    location.onLocationChanged.listen(onData);
  }
}
