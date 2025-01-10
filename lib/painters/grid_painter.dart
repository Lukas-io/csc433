import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {
  final double gridSize; // Size of each grid square
  final Color gridColor; // Color of the grid lines
  final Color axisColor; // Color of the X and Y axes
  final Color labelColor; // Color of the labels

  GridPainter({
    this.gridSize = 40,
    this.gridColor = Colors.grey,
    this.axisColor = Colors.black26,
    this.labelColor = Colors.black38,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.5;

    // Calculate the label position of the canvas
    const double startX = -20;
    final endY = size.height + 5;

    // Draw vertical grid lines and labels
    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);

      // Draw labels on the X-axis
      final labelValue = ((x - startX) / gridSize).ceil() - 1;
      _drawText(canvas, labelValue.toString(), Offset(x, endY), labelColor);
    }

    // Draw horizontal grid lines and labels
    for (double y = 0; y <= size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);

      // Draw labels on the Y-axis
      final labelValue =
          ((endY - y) / gridSize).ceil() - 1; // Invert Y-axis value
      _drawText(canvas, labelValue.toString(), Offset(startX, y), labelColor);
    }
    canvas.drawLine(
        Offset(0, size.height), Offset(size.width, size.height), paint);
  }

  // Helper function to draw text on the canvas
  void _drawText(Canvas canvas, String text, Offset position, Color color) {
    final textStyle = TextStyle(
      color: color,
      fontSize: 12,
    );
    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, position);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
