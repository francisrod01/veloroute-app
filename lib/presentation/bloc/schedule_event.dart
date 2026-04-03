abstract class ScheduleEvent {}

class LoadSchedulesByRoute extends ScheduleEvent {
  final String routeId;
  LoadSchedulesByRoute(this.routeId);
}

class RefreshSchedules extends ScheduleEvent {
  final String routeId;
  RefreshSchedules(this.routeId);
}
