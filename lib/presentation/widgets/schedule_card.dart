import 'package:flutter/material.dart';
import '../../domain/entities/schedule.dart';

class ScheduleCard extends StatelessWidget {
  final Schedule schedule;

  const ScheduleCard({ super.key, required this.schedule });

  @override
  Widget build(BuildContext context) {
    // VeloRoute brand colours
    const primaryColour = Color(0xFF1B264F);
    const accentColour = Color(0xFF00A86B);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Visual status indicator (Real-time / Punctuality)
            Container(
              width: 4,
              height: 40,
              decoration: BoxDecoration(
                color: schedule.isDelayed ? Colors.orange : accentColour,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 16),

            // Point and Route information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    schedule.stopName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColour,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    schedule.isDelayed ? "Delayed" : "In time",
                    style: TextStyle(
                      fontSize: 14,
                      color: schedule.isDelayed ? Colors.orange : accentColour,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Arrival time
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  schedule.formattedTime,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: primaryColour,
                    letterSpacing: -0.5,
                  ),
                ),

                const Icon(
                  Icons.directions_bus_filled_outlined,
                  size: 18,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}