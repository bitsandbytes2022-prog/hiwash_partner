import 'package:flutter/material.dart';

import '../../styling/app_color.dart';

class DotedVerticalLine extends StatelessWidget {
  final double? width;
  final double? height;

  const DotedVerticalLine({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width ?? 1, height ??100),
      painter: DashedLineVerticalPainter(),
    );
  }
}

class DashedLineVerticalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = size.width;

    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}