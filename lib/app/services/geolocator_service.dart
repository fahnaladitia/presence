import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return {
        'message': 'Location services are disabled.',
        'error': true,
      };
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return {
          'message': 'Location permissions are denied',
          'error': true,
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return {
        // 'position': null,
        'message':
            'Location permissions are permanently denied, we cannot request permissions.',
        'error': true,
      };
    }

    Position position = await Geolocator.getCurrentPosition();
    return {
      'position': position,
      'message': "Berhasil mendapatkan posisi device.",
      'error': false,
    };
  }
}
