
import '../../domain/repositories/i_transport_repository.dart';
import '../../domain/entities/schedule.dart';
import '../dataproviders/transport_data_client.dart';

class TransportRepository implements ITransportRepository {
  final TransportDataClient dataClient;

  TransportRepository(this.dataClient);

  @override
  Future<List<Schedule>> getSchedulesByRoute(String routeId) async {
    try {
      // Call the data client for Docker
      final rawData = await dataClient.fetchSchedules(routeId);

      // JSON dynamic mapping for the Schedule entity
      return rawData.map((json) => Schedule(
        id: json['id'] as String,
        routeId: json['route_id'] as String,
        stopName: json['stop_name'] as String,
        // Convert the hour string (HH:mm:ss) to DateTime
        scheduledTime: _parseTimeString(json['scheduled_time'] as String),
        isDelayed: json['is_delayed'] ?? false,
      )).toList();
    } catch (e) {
      // Send the error to BLoC
      rethrow;
    }
  }

  DateTime _parseTimeString(String timeStr) {
    final now = DateTime.now();
    final parts = timeStr.split(':');
    return DateTime(
      now.year, now.month, now.day,
      int.parse(parts[0]), int.parse(parts[1])
    );
  }
}