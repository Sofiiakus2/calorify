import 'dart:math';

import 'package:calorify/core/theme.dart';
import 'package:flutter/material.dart';

///chart painter
class DonutChartPainter extends CustomPainter {
  final int planCalories;
  final int leftCalories;
  final double thickness = 60;

  ///constructor
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

    final int usedCalories = planCalories - leftCalories;
    double leftAngle = 0;
    double usedAngle = 0;

    if(usedCalories< 0 && (-usedCalories) > planCalories*2){
      usedAngle = ((planCalories*2) / planCalories) * 2 * pi;
      leftAngle = usedAngle;
    }else{
      usedAngle = (usedCalories / planCalories) * 2 * pi;
      leftAngle = (leftCalories / planCalories) * 2 * pi;
    }

    const double separationOffset = 8;

    final double usedShadowOffset =
    (leftCalories == planCalories || leftCalories < planCalories / 2) ? 25 : 5;
    final double leftShadowOffset =
    (leftCalories == planCalories || leftCalories < planCalories / 2) ? 5 : 25;

    final Offset usedShadowCenter = Offset(
      center.dx + separationOffset * cos(-pi / 2 + usedAngle / 3),
      center.dy + separationOffset * sin(-pi / 2 + usedAngle / 2)
          + usedShadowOffset,
    );

    final Offset leftShadowCenter = Offset(
      center.dx + separationOffset * cos(-pi / 2 + usedAngle + leftAngle / 3),
      center.dy + separationOffset * sin(-pi / 2 + usedAngle + leftAngle / 2)
          + leftShadowOffset,
    );

    final Rect usedShadowOvalRect = Rect.fromCircle(center: usedShadowCenter,
        radius: radius - thickness / 2,);
    final Rect leftShadowOvalRect = Rect.fromCircle(center: leftShadowCenter,
        radius: radius - thickness / 2,);

    canvas.drawArc(usedShadowOvalRect, -pi / 2, usedAngle, false, borderPaint);
    canvas.drawArc(leftShadowOvalRect, -pi / 2 + usedAngle, leftAngle, false,
        borderPaint);

    final double usedOffset = (leftCalories == planCalories
        || leftCalories < planCalories / 2) ? 0 : 20;
    final double leftOffset = (leftCalories == planCalories
        || leftCalories < planCalories / 2) ? 20 : 0;


    final Offset usedCenter = Offset(center.dx + separationOffset
        * cos(-pi / 2 + usedAngle / 3),
        center.dy + separationOffset * sin(-pi / 2 + usedAngle / 2)
            - usedOffset,);
    final Offset leftCenter = Offset(center.dx + separationOffset *
        cos(-pi / 2 + usedAngle + leftAngle / 3),
        center.dy + separationOffset * sin(-pi / 2 + usedAngle + leftAngle / 2)
            - leftOffset,);

    final Rect usedOvalRect = Rect.fromCircle(center: usedCenter,
        radius: radius - thickness / 2);
    final Rect leftOvalRect = Rect.fromCircle(center: leftCenter,
        radius: radius - thickness / 2);




    if(planCalories> leftCalories){
      borderPaint.color = Colors.black;
      fillPaint.color = green;
      canvas.drawArc(usedOvalRect, -pi / 2, usedAngle, false, borderPaint);
      canvas.drawArc(usedOvalRect, -pi / 2, usedAngle, false, fillPaint);

      fillPaint.color = lightGreen;
      canvas.drawArc(leftOvalRect, -pi / 2 + usedAngle, leftAngle, false,
        borderPaint,);
      canvas.drawArc(leftOvalRect, -pi / 2 + usedAngle, leftAngle, false,
        fillPaint,);
    }else{
      borderPaint.color = Colors.black;

      fillPaint.color = lightGreen;
      canvas.drawArc(leftOvalRect, -pi / 2 + usedAngle, leftAngle, false,
        borderPaint,);
      canvas.drawArc(leftOvalRect, -pi / 2 + usedAngle, leftAngle, false,
        fillPaint,);

      fillPaint.color = green;
      canvas.drawArc(usedOvalRect, -pi / 2, usedAngle, false, borderPaint);
      canvas.drawArc(usedOvalRect, -pi / 2, usedAngle, false, fillPaint);

    }





  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
