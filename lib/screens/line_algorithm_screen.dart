import 'dart:math';

import 'package:csc433/painters/grid_painter.dart';
import 'package:flutter/material.dart';

import '../painters/line/dda_line_painter.dart';

class LineAlgorithmsScreen extends StatefulWidget {
  const LineAlgorithmsScreen({super.key});

  @override
  State<LineAlgorithmsScreen> createState() => _LineAlgorithmsScreenState();
}

class _LineAlgorithmsScreenState extends State<LineAlgorithmsScreen> {
  bool zoomEnabled = false;
  Offset? startOffset;
  Offset? endOffset;

  int intervalGap = 31;
  TransformationController? _transformationController;
  late final Size canvasSize;

  double getAngleFromPoints(Offset start, Offset end) {
    if (end == Offset.zero) {
      return 0;
    }

    // Get the differences in x and y
    double dx = end.dx - start.dx;
    double dy = end.dy - start.dy;

    // Calculate angle in radians using atan2
    double angleInRadians = atan2(dy, dx);

    // Convert to degrees if needed
    double angleInDegrees = angleInRadians * (180 / pi);

    // Normalize to 0-360 range (optional)
    if (angleInDegrees < 0) {
      angleInDegrees += 360;
    }

    return angleInDegrees;
  }

  @override
  void initState() {
    _transformationController = TransformationController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    canvasSize = Size(
        MediaQuery.sizeOf(context).width - 72,
        MediaQuery.sizeOf(context).height -
            MediaQuery.viewPaddingOf(context).vertical -
            360);
  }

  @override
  Widget build(BuildContext context) {
    int startDx = ((startOffset ?? Offset.zero).dx / intervalGap).ceil();
    int startDy = (((startOffset ?? Offset.zero).dy) / intervalGap).ceil();
    int endDx = ((endOffset ?? Offset.zero).dx / intervalGap).ceil();
    int endDy = (((endOffset ?? Offset.zero).dy) / intervalGap).ceil();

    int angle = getAngleFromPoints(
      Offset(startDx.toDouble(), startDx.toDouble()),
      Offset(endDx.toDouble(), endDy.toDouble()),
    ).ceil();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Line Algorithms"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                zoomEnabled = !zoomEnabled;
                _transformationController = TransformationController();

                if (zoomEnabled == false) {
                  _transformationController = null;
                }
              });
            },
            style: IconButton.styleFrom(
                backgroundColor: zoomEnabled ? Colors.blueGrey : null),
            icon: Icon(
              zoomEnabled ? Icons.touch_app_rounded : Icons.zoom_in_map,
              color: zoomEnabled ? Colors.white : Colors.blueGrey,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "($startDx, $startDy)",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 24.0),
                    ),
                    const Text(
                      "START",
                      style: TextStyle(letterSpacing: 0),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "$angle°",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 24.0),
                    ),
                    const Text(
                      "ANGLE",
                      style: TextStyle(letterSpacing: 0),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "($endDx,$endDy)",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 24.0),
                    ),
                    const Text(
                      "END",
                      style: TextStyle(letterSpacing: 0),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                  color: zoomEnabled
                      ? Colors.blueGrey.shade400
                      : Colors.transparent,
                  width: 4.0),
            ),
            margin: const EdgeInsets.all(8.0),
            child: InteractiveViewer(
              // Minimum zoom scale
              boundaryMargin: const EdgeInsets.all(120.0),
              maxScale: 25.0,
              transformationController: _transformationController,
              scaleFactor: 4,
              panEnabled: _transformationController != null,
              child: Container(
                alignment: Alignment.topCenter,
                padding:
                    const EdgeInsets.only(top: 24.0, left: 12.0, bottom: 36.0),
                child: GestureDetector(
                  onTapDown: zoomEnabled
                      ? null
                      : (details) {
                          if (startOffset != null && endOffset != null) {
                            startOffset = null;
                            endOffset = null;
                          }

                          setState(() {
                            if (startOffset != null) {
                              endOffset = Offset(details.localPosition.dx,
                                  canvasSize.height - details.localPosition.dy);
                            } else {
                              startOffset = Offset(details.localPosition.dx,
                                  canvasSize.height - details.localPosition.dy);
                            }
                          });
                        },
                  onPanUpdate: zoomEnabled
                      ? null
                      : (details) {
                          setState(() {
                            endOffset = Offset(details.localPosition.dx,
                                canvasSize.height - details.localPosition.dy);
                          });
                        },
                  child: Stack(
                    children: [
                      CustomPaint(
                        painter: GridPainter(
                          gridSize: intervalGap.toDouble(),
                        ),
                        size: canvasSize,
                      ),
                      // CustomPaint(
                      //   painter: MidpointLinePainter(
                      //       start: startOffset,
                      //       end: endOffset,
                      //       interval: intervalGap),
                      //   size: canvasSize,
                      // ),
                      CustomPaint(
                        painter: DdaLinePainter(
                            start: startOffset,
                            end: endOffset,
                            canvasHeight: canvasSize.height,
                            interval: intervalGap),
                        size: canvasSize,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
