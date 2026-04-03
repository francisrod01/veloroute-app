import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './data/dataproviders/transport_data_client.dart';
import './data/repositories/transport_repository.dart';
import './presentation/bloc/schedule_bloc.dart';
import './presentation/pages/schedule_screen.dart';

void main() {
  // Add it in an Injection Container
  final dataClient = TransportDataClient(baseUrl: "http://localhost:3000");
  final transportRepository = TransportRepository(dataClient);

  // No MultiBlocProvider
  BlocProvider<ScheduleBloc>(
    create: (context) => ScheduleBloc(transportRepository),
  );

  runApp(VeloRouteApp(repository: transportRepository));
}

class VeloRouteApp extends StatelessWidget {
  final TransportRepository repository;

  const VeloRouteApp({ super.key, required this.repository });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VeloRoute',
      theme: ThemeData(
        primaryColor: const Color(0xFF1B264F), // Navy Blue
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B264F),
          secondary: const Color(0xFF00A86B), // Emerald Green
        ),
        useMaterial3: true,
      ),
      // Provides Bloc to widgets tree
      home: BlocProvider(
        create: (context) => ScheduleBloc(repository),
        child: const ScheduleScreen(
          // @TODO: test ID (it should exist in the database Docker/init.sql)
          routeId: "00000000-0000-0000-0000-000000000000",
        ),
      )
    );
  }
}
