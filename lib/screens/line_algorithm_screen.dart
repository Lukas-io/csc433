import 'package:csc433/painters/grid_painter.dart';
import 'package:csc433/painters/line/midpoint_line_painter.dart';
import 'package:flutter/material.dart';

class LineAlgorithmsScreen extends StatefulWidget {
  const LineAlgorithmsScreen({super.key});

  @override
  State<LineAlgorithmsScreen> createState() => _LineAlgorithmsScreenState();
}

class _LineAlgorithmsScreenState extends State<LineAlgorithmsScreen> {
  bool zoomEnabled = false;
  Offset startOffset = const Offset(150, 150);
  Offset endOffset = const Offset(150, 150);
  int intervalGap = 40;
  late final TransformationController _transformationController;
  late final Size canvasSize = Size(
      MediaQuery.sizeOf(context).width - 72,
      MediaQuery.sizeOf(context).height -
          MediaQuery.viewPaddingOf(context).vertical -
          360);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => {});
    _transformationController = TransformationController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Line Algorithms"),
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
                      "(${(startOffset.dx / intervalGap).round()}, ${((canvasSize.height - startOffset.dy) / intervalGap).round()})",
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
                      "(${(endOffset.dx / intervalGap).round()}, ${((canvasSize.height - endOffset.dy) / intervalGap).round()})",
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
                            startOffset = details.localPosition;
                          });
                        },
                  onPanDown: zoomEnabled
                      ? null
                      : (details) {
                          setState(() {
                            startOffset = details.localPosition;
                          });
                        },
                  child: Stack(
                    children: [
                      CustomPaint(
                        painter: GridPainter(),
                        size: canvasSize,
                      ),
                      CustomPaint(
                        painter: MidpointLinePainter(
                          start: startOffset,
                          end: endOffset,
                        ),
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
