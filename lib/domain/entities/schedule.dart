class Schedule {
  final String id;
  final String routeId;
  final String stopName;
  final DateTime scheduledTime;
  final bool isDelayed;

  Schedule({
    required this.id,
    required this.routeId,
    required this.stopName,
    required this.scheduledTime,
    this.isDelayed = false,
  });

  // Helper to format time in the UI of the mobile device
  String get formattedTime =>
    "${scheduledTime.hour.toString().padLeft(2, '0')}:${scheduledTime.minute.toString().padLeft(2, '0')}";
}