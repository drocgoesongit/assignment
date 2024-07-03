import 'dart:ui';

import 'package:assignment/constants/color_const.dart';
import 'package:flutter/material.dart';

class HalfCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = softWhiteCustomColor // Adjust color as needed
      ..style = PaintingStyle.fill;

    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height), radius: size.width / 2),
      0,
      -3.14, // Angle in radians (180 degrees)
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
