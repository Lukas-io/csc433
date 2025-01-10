import 'package:flutter/material.dart';

class BresenhamLinePainter extends CustomPainter {
  final Offset start; // Starting point of the line
  final Offset end; // Ending point of the line

  BresenhamLinePainter({required this.start, required this.end});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 2.0;

    // Call the Bresenham's line drawing algorithm
    _drawBresenhamLine(canvas, start, end, paint);
  }

  void _drawBresenhamLine(
      Canvas canvas, Offset start, Offset end, Paint paint) {
    int x0 = start.dx.toInt();
    int y0 = start.dy.toInt();
    int x1 = end.dx.toInt();
    int y1 = end.dy.toInt();

    // Calculate differences
    int dx = (x1 - x0).abs();
    int dy = (y1 - y0).abs();

    // Determine the direction of the iteration
    int sx = x0 < x1 ? 1 : -1;
    int sy = y0 < y1 ? 1 : -1;

    int err = dx - dy;

    while (true) {
      // Draw each point
      canvas.drawCircle(Offset(x0.toDouble(), y0.toDouble()), 1.5, paint);

      // Check if the line has reached the end point
      if (x0 == x1 && y0 == y1) break;

      int e2 = 2 * err;

      // Adjust the error term and coordinates based on direction
      if (e2 > -dy) {
        err -= dy;
        x0 += sx;
      }
      if (e2 < dx) {
        err += dx;
        y0 += sy;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
