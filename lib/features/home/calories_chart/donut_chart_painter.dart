import 'dart:math';

import 'package:flutter/material.dart';

import '../../../theme.dart';

class DonutChartPainter extends CustomPainter {
  final double planCalories;
  final double leftCalories;
  final double thickness = 60;

  DonutChartPainter(this.planCalories, this.leftCalories);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint fillPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.butt;

    final Paint borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness + 2
      ..strokeCap = StrokeCap.butt;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    final double usedCalories = planCalories - leftCalories;
    double leftAngle = 0;
    double usedAngle = 0;

    if(usedCalories< 0 && (-usedCalories) > planCalories*2){
      usedAngle = ((planCalories*2) / planCalories) * 2 * pi;
      leftAngle = usedAngle;
    }else{
      usedAngle = (usedCalories / planCalories) * 2 * pi;
      leftAngle = (leftCalories / planCalories) * 2 * pi;
    }

    final double separationOffset = 8;

    double usedShadowOffset = (leftCalories == planCalories || leftCalories < planCalories / 2) ? 25 : 5;
    double leftShadowOffset = (leftCalories == planCalories || leftCalories < planCalories / 2) ? 5 : 25;

    final Offset usedShadowCenter = Offset(
      center.dx + separationOffset * cos(-pi / 2 + usedAngle / 3),
      center.dy + separationOffset * sin(-pi / 2 + usedAngle / 2) + usedShadowOffset,
    );

    final Offset leftShadowCenter = Offset(
      center.dx + separationOffset * cos(-pi / 2 + usedAngle + leftAngle / 3),
      center.dy + separationOffset * sin(-pi / 2 + usedAngle + leftAngle / 2) + leftShadowOffset,
    );

    Rect usedShadowOvalRect = Rect.fromCircle(center: usedShadowCenter, radius: radius - thickness / 2);
    Rect leftShadowOvalRect = Rect.fromCircle(center: leftShadowCenter, radius: radius - thickness / 2);

    canvas.drawArc(usedShadowOvalRect, -pi / 2, usedAngle, false, borderPaint);
    canvas.drawArc(leftShadowOvalRect, -pi / 2 + usedAngle, leftAngle, false, borderPaint);

    double usedOffset = (leftCalories == planCalories || leftCalories < planCalories / 2) ? 0 : 20;
    double leftOffset = (leftCalories == planCalories || leftCalories < planCalories / 2) ? 20 : 0;


    final Offset usedCenter = Offset(center.dx + separationOffset * cos(-pi / 2 + usedAngle / 3),
        center.dy + separationOffset * sin(-pi / 2 + usedAngle / 2) - usedOffset);
    final Offset leftCenter = Offset(center.dx + separationOffset * cos(-pi / 2 + usedAngle + leftAngle / 3),
        center.dy + separationOffset * sin(-pi / 2 + usedAngle + leftAngle / 2) - leftOffset);

    Rect usedOvalRect = Rect.fromCircle(center: usedCenter, radius: radius - thickness / 2);
    Rect leftOvalRect = Rect.fromCircle(center: leftCenter, radius: radius - thickness / 2);

    borderPaint.color = Colors.black;

    fillPaint.color = lightGreen;
    canvas.drawArc(leftOvalRect, -pi / 2 + usedAngle, leftAngle, false, borderPaint);
    canvas.drawArc(leftOvalRect, -pi / 2 + usedAngle, leftAngle, false, fillPaint);


    fillPaint.color = green;
    canvas.drawArc(usedOvalRect, -pi / 2, usedAngle, false, borderPaint);
    canvas.drawArc(usedOvalRect, -pi / 2, usedAngle, false, fillPaint);


  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
