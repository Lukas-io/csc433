// InkWell(
// onTap: () {
// Canvas canvas = Canvas(PictureRecorder());
//
// print("Horizontal Line (Slope 0)\n");
// drawLineWithPerformance(canvas, 0, 50, 200, 50, 'DDA');
// drawLineWithPerformance(canvas, 0, 50, 200, 50, 'Bresenham');
// drawLineWithPerformance(canvas, 0, 50, 200, 50, 'Midpoint');
//
// print("45° Line (Slope 1)\n");
// drawLineWithPerformance(canvas, 0, 0, 100, 100, 'DDA');
// drawLineWithPerformance(canvas, 0, 0, 100, 100, 'Bresenham');
// drawLineWithPerformance(canvas, 0, 0, 100, 100, 'Midpoint');
//
// print("Steep Line (Slope > 1)\n");
// drawLineWithPerformance(canvas, 0, 0, 50, 120, 'DDA');
// drawLineWithPerformance(canvas, 0, 0, 50, 120, 'Bresenham');
// drawLineWithPerformance(canvas, 0, 0, 50, 120, 'Midpoint');
//
// print("Vertical Line (Slope Undefined)\n");
// drawLineWithPerformance(canvas, 100, 0, 100, 150, 'DDA');
// drawLineWithPerformance(canvas, 100, 0, 100, 150, 'Bresenham');
// drawLineWithPerformance(canvas, 100, 0, 100, 150, 'Midpoint');
//
// // Drawing circles with Bresenham and Midpoint algorithms
// print("Horizontal Line (Slope 0)\n");
// drawCircleWithPerformance(canvas, 150, 150, 50, 'Bresenham');
// drawCircleWithPerformance(canvas, 150, 150, 50, 'Midpoint');
// print("45° Line (Slope 1)\n");
// drawCircleWithPerformance(canvas, 150, 150, 100, 'Bresenham');
// drawCircleWithPerformance(canvas, 150, 150, 100, 'Midpoint');
// print("Steep Line (Slope > 1)\n");
// drawCircleWithPerformance(canvas, 150, 150, 150, 'Bresenham');
// drawCircleWithPerformance(canvas, 150, 150, 150, 'Midpoint');
// print("Vertical Line (Slope Undefined)\n");
// drawCircleWithPerformance(canvas, 150, 150, 200, 'Bresenham');
// drawCircleWithPerformance(canvas, 150, 150, 200, 'Midpoint');
// },
// child: Container(
// alignment: Alignment.center,
// padding: const EdgeInsets.symmetric(vertical: 24.0),
// margin: const EdgeInsets.symmetric(horizontal: 24.0),
// child: const Text("Test Algorithm"),
// ),
// ),

//
// // Function to measure and draw a line using DDA, Bresenham, or Midpoint
// void drawLineWithPerformance(Canvas canvas, int startX, int startY, int endX,
//     int endY, String algorithm) async {
//   double elapsedTimeInMs = 0;
//   for (int i = 0; i <= 10000; i++) {
//     Stopwatch stopwatch = Stopwatch();
//     stopwatch.start();
//
//     // Depending on the algorithm, call the respective line drawing function
//     if (algorithm == 'DDA') {
//       drawDdaLine(canvas, startX.toDouble(), startY.toDouble(),
//           endX.toDouble(), endY.toDouble());
//     } else if (algorithm == 'Bresenham') {
//       drawBresenhamLine(canvas, startX, startY, endX, endY);
//     } else if (algorithm == 'Midpoint') {
//       drawMidpointLine(canvas, startX, startY, endX, endY);
//     }
//     stopwatch.stop();
//     elapsedTimeInMs += stopwatch.elapsedMicroseconds / 1000;
//     stopwatch.reset();
//   }
//   print(
//       '$algorithm Average Line Drawing Time: ${elapsedTimeInMs / 10000} ms');
// }
//
// // DDA Line Algorithm
// Future<void> drawDdaLine(Canvas canvas, double startX, double startY,
//     double endX, double endY) async {
//   double dx = endX - startX;
//   double dy = endY - startY;
//   double steps = (dx.abs() > dy.abs()) ? dx.abs() : dy.abs();
//   double xIncrement = dx / steps;
//   double yIncrement = dy / steps;
//   double x = startX.toDouble();
//   double y = startY.toDouble();
//
//   for (int i = 0; i <= steps; i++) {
//     canvas.drawCircle(Offset(x, y), 1, Paint()..color = Colors.blue);
//     x += xIncrement;
//     y += yIncrement;
//   }
// }
//
// // Bresenham's Line Algorithm
// void drawBresenhamLine(
//     Canvas canvas, int startX, int startY, int endX, int endY) {
//   int dx = (endX - startX).abs();
//   int dy = (endY - startY).abs();
//   int sx = (startX < endX) ? 1 : -1;
//   int sy = (startY < endY) ? 1 : -1;
//   int err = dx - dy;
//
//   while (true) {
//     canvas.drawCircle(Offset(startX.toDouble(), startY.toDouble()), 1,
//         Paint()..color = Colors.red);
//
//     if (startX == endX && startY == endY) break;
//     int e2 = err * 2;
//     if (e2 > -dy) {
//       err -= dy;
//       startX += sx;
//     }
//     if (e2 < dx) {
//       err += dx;
//       startY += sy;
//     }
//   }
// }
//
// // Midpoint Line Algorithm
// void drawMidpointLine(
//     Canvas canvas, int startX, int startY, int endX, int endY) {
//   int dx = endX - startX;
//   int dy = endY - startY;
//   int p = 2 * dy - dx;
//   int twoDy = 2 * dy;
//   int twoDxy = 2 * (dy - dx);
//
//   int x = startX;
//   int y = startY;
//
//   for (int i = 0; i <= dx; i++) {
//     canvas.drawCircle(
//         Offset(x.toDouble(), y.toDouble()), 1, Paint()..color = Colors.green);
//
//     if (p >= 0) {
//       y++;
//       p += twoDxy;
//     } else {
//       p += twoDy;
//     }
//     x++;
//   }
// }
//
// // Function to draw a circle using Bresenham's Circle Algorithm or Midpoint Circle Algorithm
// void drawCircleWithPerformance(
//     Canvas canvas, int centerX, int centerY, int radius, String algorithm) {
//   Stopwatch stopwatch = Stopwatch();
//   double elapsedTimeInMs = 0;
//   for (int i = 0; i <= 10000; i++) {
//     stopwatch.start();
//
//     if (algorithm == 'Bresenham') {
//       drawBresenhamCircle(
//           canvas, centerX.toDouble(), centerY.toDouble(), radius);
//     } else if (algorithm == 'Midpoint') {
//       drawMidpointCircle(
//           canvas, centerX.toDouble(), centerY.toDouble(), radius);
//     }
//
//     stopwatch.stop();
//     elapsedTimeInMs += stopwatch.elapsedMicroseconds / 1000;
//     stopwatch.reset();
//   }
//   print(
//       '$algorithm Average Circle Drawing Time: ${elapsedTimeInMs / 10000} ms');
// }
//
// // Bresenham's Circle Algorithm
// void drawBresenhamCircle(
//     Canvas canvas, double centerX, double centerY, int radius) {
//   int x = 0;
//   int y = radius;
//   int p = 3 - 2 * radius;
//
//   while (x <= y) {
//     canvas.drawCircle(
//         Offset(centerX + x, centerY + y), 1, Paint()..color = Colors.blue);
//     canvas.drawCircle(
//         Offset(centerX - x, centerY + y), 1, Paint()..color = Colors.blue);
//     canvas.drawCircle(
//         Offset(centerX + x, centerY - y), 1, Paint()..color = Colors.blue);
//     canvas.drawCircle(
//         Offset(centerX - x, centerY - y), 1, Paint()..color = Colors.blue);
//     canvas.drawCircle(
//         Offset(centerX + y, centerY + x), 1, Paint()..color = Colors.blue);
//     canvas.drawCircle(
//         Offset(centerX - y, centerY + x), 1, Paint()..color = Colors.blue);
//     canvas.drawCircle(
//         Offset(centerX + y, centerY - x), 1, Paint()..color = Colors.blue);
//     canvas.drawCircle(
//         Offset(centerX - y, centerY - x), 1, Paint()..color = Colors.blue);
//
//     if (p < 0) {
//       p += 4 * x + 6;
//     } else {
//       p += 4 * (x - y) + 10;
//       y--;
//     }
//     x++;
//   }
// }
//
// // Midpoint Circle Algorithm
// void drawMidpointCircle(
//     Canvas canvas, double centerX, double centerY, int radius) {
//   int x = 0;
//   int y = radius;
//   int p = 1 - radius;
//
//   while (x <= y) {
//     canvas.drawCircle(
//         Offset(centerX + x, centerY + y), 1, Paint()..color = Colors.green);
//     canvas.drawCircle(
//         Offset(centerX - x, centerY + y), 1, Paint()..color = Colors.green);
//     canvas.drawCircle(
//         Offset(centerX + x, centerY - y), 1, Paint()..color = Colors.green);
//     canvas.drawCircle(
//         Offset(centerX - x, centerY - y), 1, Paint()..color = Colors.green);
//     canvas.drawCircle(
//         Offset(centerX + y, centerY + x), 1, Paint()..color = Colors.green);
//     canvas.drawCircle(
//         Offset(centerX - y, centerY + x), 1, Paint()..color = Colors.green);
//     canvas.drawCircle(
//         Offset(centerX + y, centerY - x), 1, Paint()..color = Colors.green);
//     canvas.drawCircle(
//         Offset(centerX - y, centerY - x), 1, Paint()..color = Colors.green);
//
//     if (p < 0) {
//       p += 2 * x + 3;
//     } else {
//       p += 2 * (x - y) + 5;
//       y--;
//     }
//     x++;
//   }
// }
