import 'package:csc433/painters/grid_painter.dart';
import 'package:csc433/widgets/radius_slider.dart';
import 'package:flutter/material.dart';

import '../painters/circle/bresenham_circle_painter.dart';
import '../painters/circle/midpoint_circle_painter.dart';

class CircleAlgorithmsScreen extends StatefulWidget {
  const CircleAlgorithmsScreen({super.key});

  @override
  State<CircleAlgorithmsScreen> createState() => _CircleAlgorithmsScreenState();
}

class _CircleAlgorithmsScreenState extends State<CircleAlgorithmsScreen> {
  int radius = 3;
  bool zoomEnabled = false;
  Offset centerOffset = const Offset(150, 150);
  int intervalGap = 40;
  late final TransformationController _transformationController;
  late final Size canvasSize;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Circle Algorithms"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                zoomEnabled = !zoomEnabled;
                if (zoomEnabled == false) {
                  _transformationController.value = Matrix4.identity();
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
                      "(${(centerOffset.dx / intervalGap).round()}, ${((canvasSize.height - centerOffset.dy) / intervalGap).round()})",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 24.0),
                    ),
                    const Text(
                      "CENTER",
                      style: TextStyle(letterSpacing: 0),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "$radius",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 24.0),
                    ),
                    const Text(
                      "RADIUS",
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
              maxScale: 20.0,
              transformationController: _transformationController,
              scaleFactor: 4,
              child: Container(
                alignment: Alignment.topCenter,
                padding:
                    const EdgeInsets.only(top: 24.0, left: 12.0, bottom: 36.0),
                child: GestureDetector(
                  onPanUpdate: zoomEnabled
                      ? null
                      : (details) {
                          setState(() {
                            centerOffset = details.localPosition;
                          });
                        },
                  onPanDown: zoomEnabled
                      ? null
                      : (details) {
                          setState(() {
                            centerOffset = details.localPosition;
                          });
                        },
                  child: Stack(
                    children: [
                      CustomPaint(
                        painter: GridPainter(gridSize: intervalGap.toDouble()),
                        size: canvasSize,
                      ),
                      CustomPaint(
                        painter: BresenhamCirclePainter(
                          center: centerOffset,
                          radius: radius,
                          interval: intervalGap,
                        ),
                        size: canvasSize,
                      ),
                      CustomPaint(
                        painter: MidpointCirclePainter(
                          center: centerOffset,
                          radius: radius,
                          interval: intervalGap,
                        ),
                        size: canvasSize,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: RadiusSlider(
              onChanged: (value) {
                setState(() {
                  radius = value;
                });
              },
              range: 5,
              initialValue: radius,
            ),
          ),
        ],
      ),
    );
  }
}
