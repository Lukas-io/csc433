import 'package:flutter/material.dart';

class RadiusSlider extends StatefulWidget {
  final Function(int value) onChanged;
  final int range;
  final int initialValue;

  const RadiusSlider(
      {super.key,
      required this.onChanged,
      this.range = 30,
      required this.initialValue});

  @override
  State<RadiusSlider> createState() => _RadiusSliderState();
}

class _RadiusSliderState extends State<RadiusSlider> {
  late double value;

  @override
  void initState() {
    value = widget.initialValue.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Slider.adaptive(
      value: value,
      thumbColor: Colors.blue,
      activeColor: Colors.blue.shade400,
      min: 0.0,
      divisions: widget.range,
      max: widget.range.roundToDouble(),
      onChanged: (newValue) {
        setState(() {
          value = newValue;
        });
        widget.onChanged(value.round());
      },
    );
  }
}
