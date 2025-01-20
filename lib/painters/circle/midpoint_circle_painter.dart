import 'package:flutter/material.dart';

class MidpointCirclePainter extends CustomPainter {
  final Offset center; // Center of the circle
  final int radius; // Radius of the circle
  final int interval;

  MidpointCirclePainter({
    required this.center,
    required this.radius,
    required this.interval,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0;
    final centerPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0;

    //Plot center
    double centerDx = (center.dx / interval).round() * interval.toDouble();
    double centerDy = (center.dy / interval).round() * interval.toDouble();
    Offset centerPoint = Offset(centerDx, centerDy);

    canvas.drawCircle(centerPoint, radius.toDouble() + 4, centerPaint);

    // Call the Midpoint Circle algorithm
    _drawCircle(canvas, centerPoint, radius.toDouble(), paint);
  }

  void _drawCircle(Canvas canvas, Offset center, double radius, Paint paint) {
    int x = 0;
    int y = radius.toInt() * interval;
    int p = 1 - radius.toInt() * interval; // Initial decision parameter

    // Plot the initial points in all 8 octant
    _plotCirclePoints(
        canvas: canvas, center: center, x: x, y: y, paint: paint, radius: 4.0);

    // Use the circle symmetry to plot the rest of the points
    while (x < y) {
      x += interval;

      // Check if the decision parameter needs adjustment
      if (p <= 0) {
        p = p + 2 * x + 1; // Decision to move horizontally
      } else {
        y -= interval; // Mo ve vertically
        p = p + 2 * x - 2 * y + 1;
      }

      // Plot the points for the current values of (x, y)
      _plotCirclePoints(
        canvas: canvas,
        center: center,
        x: x,
        y: y,
        paint: paint,
        radius: 4.0,
      );
    }
  }

  void _plotCirclePoints({
    required Canvas canvas,
    required Offset center,
    required int x,
    required int y,
    required Paint paint,
    required double radius,
  }) {
    // The 8 symmetric points of a circle
    canvas.drawCircle(
        Offset(center.dx + x, center.dy + y), radius, paint); // Octant 1
    canvas.drawCircle(
        Offset(center.dx - x, center.dy + y), radius, paint); // Octant 2
    canvas.drawCircle(
        Offset(center.dx + x, center.dy - y), radius, paint); // Octant 4
    canvas.drawCircle(
        Offset(center.dx - x, center.dy - y), radius, paint); // Octant 3
    canvas.drawCircle(
        Offset(center.dx + y, center.dy + x), radius, paint); // Octant 5
    canvas.drawCircle(
        Offset(center.dx - y, center.dy + x), radius, paint); // Octant 6
    canvas.drawCircle(
        Offset(center.dx + y, center.dy - x), radius, paint); // Octant 7
    canvas.drawCircle(
        Offset(center.dx - y, center.dy - x), radius, paint); // Octant 8
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
