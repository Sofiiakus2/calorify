import 'package:flutter/material.dart';
import 'dart:async';

class ScannerOverlay extends StatefulWidget {
  @override
  _ScannerOverlayState createState() => _ScannerOverlayState();
}

class _ScannerOverlayState extends State<ScannerOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 300,
          width: 300,
          child: CustomPaint(
            painter: ScannerBorderPainter(),
          ),
        ),
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Align(
                alignment: Alignment(0, _animation.value * 2 - 1),
                child: Container(
                  width: 300,
                  height: 2,
                  color: Colors.yellow,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ScannerBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final double cornerRadius = 10; // Змінюємо радіус заокруглення
    final RRect rRect = RRect.fromRectAndRadius(
      Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height)),
      Radius.circular(cornerRadius),
    );

    canvas.drawRRect(rRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}