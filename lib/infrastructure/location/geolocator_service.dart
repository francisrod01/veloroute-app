import 'package:geolocator/geolocator.dart';

import './location_settings_factory.dart';
import '../../domain/services/location_service.dart';

class GeolocatorService implements ILocationService {
  @override
  Future<bool> checkPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return false;

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) return false;

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  @override
  Future<Position?> getCurrentPosition() async {
    if (!await checkPermissions()) return null;

    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettingsFactory.getSettings(),
    );
  }

  @override
  Stream<Position> getPositionStream() {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettingsFactory.getSettings(
        distanceFilter: 15, // Slightly higher for streaming to save battery
      ),
    );
  }
}
