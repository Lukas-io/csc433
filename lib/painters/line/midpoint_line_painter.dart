import 'package:flutter/material.dart';

class MidpointLinePainter extends CustomPainter {
  final Offset start; // Starting point of the line
  final Offset end; // Ending point of the line
  final int interval;

  MidpointLinePainter(
      {required this.start, required this.end, required this.interval});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 2.0;

    // Call the Midpoint Line drawing algorithm
    _drawMidpointLine(canvas, start, end, paint);
  }

  void _drawMidpointLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    int x0 = start.dx.toInt();
    int y0 = start.dy.toInt();
    int x1 = end.dx.toInt();
    int y1 = end.dy.toInt();

    // Calculate the differences
    int dx = x1 - x0;
    int dy = y1 - y0;

    // Determine the slope of the line
    bool isSteep = (dy.abs() > dx.abs());

    // If the line is steep, swap x and y coordinates
    if (isSteep) {
      // Swap x0 and y0
      int temp = x0;
      x0 = y0;
      y0 = temp;

      // Swap x1 and y1
      temp = x1;
      x1 = y1;
      y1 = temp;

      // Recalculate differences
      dx = x1 - x0;
      dy = y1 - y0;
    }

    // Swap the start and end points if necessary to ensure left-to-right drawing
    if (x0 > x1) {
      int temp = x0;
      x0 = x1;
      x1 = temp;

      temp = y0;
      y0 = y1;
      y1 = temp;
    }

    int d = 2 * dy.abs() - dx;
    int yIncrement = (y0 < y1) ? 1 : -1;

    // Draw each point using the Midpoint algorithm
    int y = y0;
    for (int x = x0; x <= x1; x++) {
      if (isSteep) {
        // If the line is steep, plot (y, x)
        canvas.drawCircle(Offset(y.toDouble(), x.toDouble()), 1.5, paint);
      } else {
        // Otherwise, plot (x, y)
        canvas.drawCircle(Offset(x.toDouble(), y.toDouble()), 1.5, paint);
      }

      // Update the decision parameter and y-coordinate
      if (d > 0) {
        y += yIncrement;
        d -= 2 * dx;
      }
      d += 2 * dy.abs();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
