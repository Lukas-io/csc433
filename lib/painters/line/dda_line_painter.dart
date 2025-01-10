import 'package:flutter/material.dart';

class DdaLinePainter extends CustomPainter {
  final Offset start;
  final Offset end;

  DdaLinePainter({required this.start, required this.end});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue // Color of the points
      ..style = PaintingStyle.fill;

    // DDA Algorithm Implementation
    double dx = end.dx - start.dx;
    double dy = end.dy - start.dy;

    // Determine the number of steps needed
    int steps = dx.abs() > dy.abs() ? dx.abs().round() : dy.abs().round();

    // Calculate the increments for x and y per step
    double xIncrement = dx / steps;
    double yIncrement = dy / steps;

    // Initial position
    double x = start.dx;
    double y = start.dy;
    // Draw discrete points along the line
    for (int i = 0; i <= steps; i++) {
      // Plot each point as a small circle
      canvas.drawCircle(Offset(x.roundToDouble(), y.roundToDouble()), 1, paint);
      x += xIncrement;
      y += yIncrement;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
