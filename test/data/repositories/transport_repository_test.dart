import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veloroute_app/data/repositories/transport_repository.dart';
import '../../mocks.dart';

void main() {
  late TransportRepository repository;
  late MockDataClient mockDataClient;

  setUp(() {
    mockDataClient = MockDataClient();
    repository = TransportRepository(mockDataClient);
  });

  test('Must return a Schedule list when DataClient responds with success', () async {
    // Given..
    final mockJson = [
      {
        "id": "1",
        "route_id": "route_101",
        "stop_name": "Central Terminal",
        "scheduled_time": "14:30:00",
        "is_delayed": false
      }
    ];

    when(() => mockDataClient.fetchSchedules(any()))
      .thenAnswer((_) async => mockJson);
    
    // When..
    final result = await repository.getSchedulesByRoute("route_101");

    // Then..
    expect(result, isA<List>());
    expect(result.first.stopName, "Central Terminal");
    expect(result.first.formattedTime, "14:30");
  });
}