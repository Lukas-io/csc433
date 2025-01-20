import 'dart:math';

import 'package:flutter/material.dart';

class DdaLinePainter extends CustomPainter {
  final Offset? start;
  final Offset? end;

  final int interval;
  final double canvasHeight;

  DdaLinePainter(
      {required this.start,
      required this.end,
      required this.canvasHeight,
      required this.interval});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue // Color of the points
      ..style = PaintingStyle.fill;

    bool onePoint = false;
    bool twoPoint = false;

    if (start != null) {
      onePoint = true;
    }
    if (end != null) {
      twoPoint = true;
    }

    if (onePoint) {
      double dx = (start!.dx / interval).floor() * interval.toDouble();
      double dy =
          ((canvasHeight - start!.dy) / interval).floor() * interval.toDouble();

      Rect rect = Rect.fromPoints(
        Offset(dx, dy),
        Offset(dx + interval, dy + interval),
      );
      canvas.drawRect(rect, paint);
    }

    if (twoPoint) {
      // DDA Algorithm Implementation
      int dx = (end!.dx / interval.toDouble()).floor() -
          (start!.dx / interval.toDouble()).floor();
      int dy = (end!.dy / interval.toDouble()).floor() -
          (start!.dy / interval.toDouble()).floor();

      int endDx = (end!.dx / interval).floor();
      int endDy = ((canvasHeight - end!.dy) / interval).floor();
      int startDx = (start!.dx / interval).floor();
      int startDy = ((canvasHeight - start!.dy) / interval).floor();

      // Determine the number of steps needed
      int steps = max(dx.abs(), dy.abs());

      // Initial position
      double x = startDx.toDouble();
      double y = startDy.toDouble();

      print("STARTING: $steps");

      void plotPoint(int xInt, int yInt) {
        double x = xInt.toDouble() * interval;
        double y = yInt.toDouble() * interval;
        Rect rect = Rect.fromPoints(
          Offset(x, y),
          Offset(x + interval, y + interval),
        );
        canvas.drawRect(rect, paint);
      }

      double xDirection = dx / steps;
      double yDirection = dy / steps;

      // Draw discrete points along the line
      for (int i = 1; i <= steps; i++) {
        // double m = (x - endDx) != 0 ? ((y - endDy) / (x - endDx)).abs() : 0;

        // int xDirection = endDx - startDx < 0 ? -1 : 1;
        // int yDirection = endDy - startDy < 0 ? -1 : 1;

        // print(m);
        x += xDirection;
        y -= yDirection;
        plotPoint(x.round(), y.round());

        // if (m > 1) {
        //   y += yDirection;
        //   if (m == 0) {
        //     x += xDirection;
        //   } else {
        //     x += (1 / m) * xDirection;
        //   }
        //   plotPoint(x.round(), y.round());
        // } else if (m == 1) {
        //   y += yDirection;
        //   x += xDirection;
        //   plotPoint(x.round(), y.round());
        // } else {
        //   x += xDirection;
        //   y += m * yDirection;
        //   plotPoint(x.round(), y.round());
        // }

        // print({x.round(), 25 - y.round()});
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
