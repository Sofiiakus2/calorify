
import 'package:flutter/material.dart';

import 'donut_chart_painter.dart';

class CalorieChart extends StatelessWidget {
  final double totalCalories = 1950;
  final double remainingCalories = 1500;

  const CalorieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(-0.8)
        ..rotateY(-0.1),
      alignment: Alignment.center,
      child: CustomPaint(
        size: Size(200, 200),
        painter: DonutChartPainter(totalCalories, remainingCalories),
      ),
    );

  }
}

