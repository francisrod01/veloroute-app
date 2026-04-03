import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:veloroute_app/presentation/bloc/schedule_bloc.dart';
import 'package:veloroute_app/presentation/bloc/schedule_event.dart';
import 'package:veloroute_app/presentation/bloc/schedule_state.dart';
import 'package:veloroute_app/domain/entities/schedule.dart';
import '../../mocks.dart';

void main() {
  late MockTransportRepository mockRepository;
  late ScheduleBloc scheduleBloc;

  setUp(() {
    mockRepository = MockTransportRepository();
    scheduleBloc = ScheduleBloc(mockRepository);
  });

  tearDown(() => scheduleBloc.close());

  final tSchedules = [
    Schedule(id: "1", routeId: "101", stopName: "Point A", scheduledTime: DateTime.now())
  ];

  blocTest<ScheduleBloc, ScheduleState>(
    'Must emit [Loading, Loaded] when LoadSchedulesByRoute is emitted with success',
    build: () {
      when(() => mockRepository.getSchedulesByRoute(any()))
        .thenAnswer((_) async => tSchedules);
      return scheduleBloc;
    },
    act: (bloc) => bloc.add(LoadSchedulesByRoute("101")),
    expect: () => [
      isA<ScheduleLoading>(),
      isA<ScheduleLoaded>(),
    ],
  );

  blocTest<ScheduleBloc, ScheduleState>(
    'Must emit [Loading, Error] when the search fails',
    build: () {
      when(() => mockRepository.getSchedulesByRoute(any()))
        .thenThrow(Exception("Error to connect to the servers."));
      return scheduleBloc;
    },
    act: (bloc) => bloc.add(LoadSchedulesByRoute("101")),
    expect: () => [
      isA<ScheduleLoading>(),
      isA<ScheduleError>(),
    ],
  );
}
