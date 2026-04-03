import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veloroute_app/domain/repositories/i_transport_repository.dart';
import 'package:veloroute_app/presentation/delegates/route_search_delegate.dart';
import '../bloc/schedule_bloc.dart';
import '../bloc/schedule_event.dart';
import '../bloc/schedule_state.dart';
import '../widgets/schedule_card.dart';
import '../../domain/entities/schedule.dart';
// import the new Logo widget
import '../widgets/veloroute_logo.dart';

class ScheduleScreen extends StatefulWidget {
  final String routeId;

  const ScheduleScreen({super.key, required this.routeId});

  @override
  State<StatefulWidget> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ScheduleBloc>().add(LoadSchedulesByRoute(widget.routeId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar widht Brand Name
      appBar: AppBar(
        title: const Text("VeloRoute Schedules"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search Transit Lines',
            onPressed: () {
              // Trigger the native Flutter Search Overlay
              showSearch(
                context: context,
                delegate: RouteSearchDelegate(
                  context.read<ITransportRepository>(),
                ),
              );
            },
          ),
        ],
      ),

      // Use a Column to show the logo header above the list
      body: Column(
        children: [
          // BRAND HEADER SECTION
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display the logo (primary colour)
                VeloRouteLogo(size: 60),
                SizedBox(width: 16),
                Text(
                  "VeloRoute",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Color(0xFF1B264F), // Use Primary Colour
                  ),
                ),
              ],
            ),
          ),

          // PREVIOUS LIST LOGIC
          Expanded(
            child: BlocBuilder<ScheduleBloc, ScheduleState>(
              builder: (context, state) {
                if (state is ScheduleLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ScheduleLoaded) {
                  final List<Schedule> list = state.schedules;

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<ScheduleBloc>().add(
                        RefreshSchedules(widget.routeId),
                      );
                    },
                    child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final item = list[index];
                        return ScheduleCard(schedule: item);
                      },
                    ),
                  );
                } else if (state is ScheduleError) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: Text("Select a route to start."));
              },
            ),
          ),
        ], // children
      ), // body
    );
  }
}
