import 'package:geolocator/geolocator.dart';

abstract class ILocationService {
  Future<Position?> getCurrentPosition();
  Future<bool> checkPermissions();
  Stream<Position> getPositionStream();
}