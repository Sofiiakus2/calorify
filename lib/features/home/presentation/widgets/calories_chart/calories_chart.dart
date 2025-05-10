
import 'package:calorify/core/provider/user_provide.dart';
import 'package:calorify/features/home/presentation/widgets/calories_chart/donut_chart_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///calories chart
class CaloriesChart extends StatelessWidget {
  final int totalCalories;
  final int remainingCalories;
  ///
  const CaloriesChart({required this.totalCalories, super.key, required this.remainingCalories});

  @override
  Widget build(BuildContext context) {

    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(-0.8)
        ..rotateY(-0.1),
      alignment: Alignment.center,
      child: CustomPaint(
        size: const Size(200, 200),
        painter: DonutChartPainter(totalCalories, remainingCalories.toInt()),
      ),
    );
  }

  int _getUserTotalCalories(BuildContext context) {
    return context.read<UserProvider>().user.calories ?? 0;
  }

  double _getRemainingCalories(BuildContext context) {
    return context.read<UserProvider>().user.leftCalories ?? 0;
  }

}

