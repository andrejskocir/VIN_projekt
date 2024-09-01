import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class BathFillProgress extends StatefulWidget {
  final double distance; // Distance input, can be updated based on sensor

  const BathFillProgress({Key? key, required this.distance}) : super(key: key);

  @override
  _BathFillProgressState createState() => _BathFillProgressState();
}

class _BathFillProgressState extends State<BathFillProgress> {
  late ValueNotifier<double> progressNotifier;

  @override
  void initState() {
    super.initState();
    // Initializing the ValueNotifier with the correct percentage
    progressNotifier = ValueNotifier<double>(calculateFillPercentage(widget.distance));
  }

  @override
  void didUpdateWidget(covariant BathFillProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update the progress value whenever the distance changes
    progressNotifier.value = calculateFillPercentage(widget.distance);
  }

  @override
  void dispose() {
    progressNotifier.dispose();
    super.dispose();
  }

  // Calculate the percentage fill based on distance
  double calculateFillPercentage(double distance) {
    if (distance <= 20) return 100; // 20 cm or less is 100% full
    if (distance >= 40) return 0;  // 40 cm or more is 0% full
    // Map distance linearly between 20 and 40 cm to 100% and 0%
    return ((40 - distance) / 20) * 100; // 20 is the range from 20 to 40
  }

  @override
  Widget build(BuildContext context) {
    return SimpleCircularProgressBar(
      size: 100, // Size of the widget
      progressStrokeWidth: 15,
      backStrokeWidth: 15,
      maxValue: 100, // Max value representing 100% fill
      valueNotifier: progressNotifier, // Notifier that updates the progress bar
      mergeMode: true,
      onGetText: (double value) {
        return Text('${value.toInt()}%'); // Display percentage inside the progress bar
      },
      progressColors: [Colors.blue], // Color of the progress bar
      fullProgressColor: Colors.green, // Color when full
      backColor: Colors.grey.shade300, // Background color of the progress bar
      animationDuration: 0, // Disable animation for instant update
    );
  }
}
