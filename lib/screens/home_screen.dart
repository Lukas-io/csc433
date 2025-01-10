import 'package:csc433/screens/circle_algorithm_screen.dart';
import 'package:flutter/material.dart';

import 'line_algorithm_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CSC433 - Computer Graphics"),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LineAlgorithmsScreen(),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              child: const Text("Line Algorithm"),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CircleAlgorithmsScreen(),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              child: const Text("Circle Algorithm"),
            ),
          ),
        ],
      ),
    );
  }
}
