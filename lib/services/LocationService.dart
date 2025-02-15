import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<bool> checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // التحقق من تفعيل خدمة الموقع
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // طلب من المستخدم تفعيل GPS
      return false;
    }

    // التحقق من الأذونات
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  static Future<Position?> getCurrentLocation() async {
    try {
      if (await checkLocationPermission()) {
        return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high
        );
      }
      return null;
    } catch (e) {
      print('Error getting location: $e');
      return null;
    }
  }
}
