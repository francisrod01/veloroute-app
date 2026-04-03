import '../entities/schedule.dart';

abstract class ITransportRepository {
  // Fetches all schedules for a specific route from the data source
  Future<List<Schedule>> getSchedulesByRoute(String routeId);
}