import 'package:flutter_bloc/flutter_bloc.dart';
import './schedule_event.dart';
import './schedule_state.dart';
import '../../domain/repositories/i_transport_repository.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ITransportRepository repository;

  ScheduleBloc(this.repository) : super(ScheduleInitial()) {
    // Registers the Event mapping
    on<LoadSchedulesByRoute>(_onLoadSchedules);
    on<RefreshSchedules>(_onRefreshSchedules);
  }

  Future<void> _onLoadSchedules(
    LoadSchedulesByRoute event,
    Emitter<ScheduleState> emit
  ) async {
    emit(ScheduleLoading());
    try {
      // Calls Repository, that calls Docker
      final schedules = await repository.getSchedulesByRoute(event.routeId);

      if (schedules.isEmpty) {
        emit(ScheduleError("No record found to this route."));
      } else {
        emit(ScheduleLoaded(schedules));
      }
    } catch (e) {
      // Connection or parsing error
      emit(ScheduleError(e.toString()));
    }
  }

  Future<void> _onRefreshSchedules(
    RefreshSchedules event,
    Emitter<ScheduleState> emit
  ) async {
    // Note: Don't emit ScheduleLoading() here to not "clear" the screen
    // and cause flickering. The RefreshIndicator take care of the visual feedback.
    try {
      final schedules = await repository.getSchedulesByRoute(event.routeId);
      emit(ScheduleLoaded(schedules));
    } catch (e) {
      emit(ScheduleError("Error to update the records."));
    }
  }
}