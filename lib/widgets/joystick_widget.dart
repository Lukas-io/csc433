import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class CustomJoystick extends StatefulWidget {
  final double baseRadius; // Radius of the joystick base
  final double knobRadius; // Radius of the knob
  final double sensitivity; // Speed multiplier for the joystick movement
  final Function(Offset position) onPositionChanged;

  const CustomJoystick({
    super.key,
    required this.baseRadius,
    required this.knobRadius,
    required this.sensitivity,
    required this.onPositionChanged,
  });

  @override
  State<CustomJoystick> createState() => _CustomJoystickState();
}

class _CustomJoystickState extends State<CustomJoystick> {
  Offset _knobPosition = Offset.zero; // Relative position of the knob
  Timer? timer;
  Offset _previousOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.baseRadius * 2,
      height: widget.baseRadius * 2,
      child: GestureDetector(
        onPanUpdate: (details) {
          timer?.cancel();
          setState(() {
            // Calculate updated position based on sensitivity
            Offset updatedPosition =
                _knobPosition + details.delta * widget.sensitivity;

            // Constrain the position to the joystick boundary
            if (updatedPosition.distance <=
                widget.baseRadius - widget.knobRadius) {
              _knobPosition = updatedPosition;
            } else {
              double angle = atan2(updatedPosition.dy, updatedPosition.dx);
              _knobPosition = Offset(
                (widget.baseRadius - widget.knobRadius) * cos(angle),
                (widget.baseRadius - widget.knobRadius) * sin(angle),
              );
            }
            final relativeOffset =
                _knobPosition / (widget.baseRadius - widget.knobRadius);
            widget.onPositionChanged(
              relativeOffset - _previousOffset,
            );
            _previousOffset = relativeOffset;
            // Normalize the position and pass to callback
            // timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
            //   widget.onPositionChanged(
            //     relativeOffset,
            //   );
            // });
          });
        },
        onPanEnd: (_) {
          setState(() {
            _knobPosition = Offset.zero; // Reset to center when released
            timer?.cancel();
          });
        },
        child: CustomPaint(
          painter: JoystickPainter(
            knobPosition: _knobPosition,
            baseRadius: widget.baseRadius,
            knobRadius: widget.knobRadius,
          ),
        ),
      ),
    );
  }
}

class JoystickPainter extends CustomPainter {
  final Offset knobPosition;
  final double baseRadius;
  final double knobRadius;

  JoystickPainter({
    required this.knobPosition,
    required this.baseRadius,
    required this.knobRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint basePaint = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.fill;

    Paint borderPaint = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Paint knobPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    // Draw joystick base
    canvas.drawCircle(
      Offset(baseRadius, baseRadius),
      baseRadius,
      basePaint,
    );
    canvas.drawCircle(
      Offset(baseRadius, baseRadius),
      baseRadius,
      borderPaint,
    );

    // Draw joystick knob
    Offset knobCenter = Offset(baseRadius, baseRadius) + knobPosition;
    canvas.drawCircle(knobCenter, knobRadius, knobPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
