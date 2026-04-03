import 'package:flutter/material.dart';
import 'dart:math' as math;

class VeloRouteLogo extends StatelessWidget {
  final double size;
  final bool usePrimaryColour;

  const VeloRouteLogo({
    super.key,
    this.size = 100,
    this.usePrimaryColour = true
  });

  @override
  Widget build(BuildContext context) {
    // Defines the brand colours based on the proposal
    const primaryColour = Color(0xFF1B264F); // Navy Blue
    const secondaryColour = Color(0xFF00A86B); // Emerald Green

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _VeloRouteLogoPainter(
          colour: usePrimaryColour ? primaryColour : secondaryColour,
        ),
      )
    );
  }
}

class _VeloRouteLogoPainter extends CustomPainter {
  final Color colour;

  _VeloRouteLogoPainter({ required this.colour });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = colour
      ..strokeWidth = size.width * 0.08 // Proportional stroke
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    
    final dotPaint = Paint()
      ..color = colour
      ..style = PaintingStyle.fill;
    
    // Use a central path for drawning the main "V-Route" shape
    final path = Path();

    // 1. Draw the "V" base (arrow/movement)
    path.moveTo(size.width * 0.1, size.height * 0.7);
    path.lineTo(size.width * 0.5, size.height * 03); // Peak of."V"
    path.lineTo(size.width * 0.9, size.height * 0.7);

    // 2. Add the "Route" curve, extending the path
    // An arc representing the path moving between stops
    path.arcTo(
      Rect.fromCircle(
        center: Offset(size.width * 0.6, size.height * 0.7),
        radius: size.width * 0.4
      ),
      0, // Start angle
      math.pi / 2, // Sweep angle (90 degrees)
      false,
    );

    canvas.drawPath(path, paint);

    // 3. Draw the "Stops" (Dots) - representing nodes/modes
    // Reusable radius calculation
    final dotRadius = size.width * 0.06;

    // Stop 1 (Start/End)
    canvas.drawCircle(Offset(size.width * 0.1, size.height * 0.7), dotRadius, dotPaint);

    // Stop 2 (Peak)
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.3), dotRadius, dotPaint);

    // Stop 3 (Next. Segment)
    canvas.drawCircle(Offset(size.width * 0.9, size.height * 0.7), dotRadius, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}