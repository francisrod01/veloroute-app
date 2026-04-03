import '../../domain/entities/schedule.dart';

abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}
class ScheduleLoading extends ScheduleState {}
class ScheduleLoaded extends ScheduleState {
  final List<Schedule> schedules;
  ScheduleLoaded(this.schedules);
}
class ScheduleError extends ScheduleState {
  final String message;
  ScheduleError(this.message);
}