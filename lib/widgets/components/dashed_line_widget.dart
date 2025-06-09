import 'package:flutter/material.dart';

import '../../styling/app_color.dart';



class DashedLineWidget extends StatelessWidget {
  final double? width;
  final double? height;

  const DashedLineWidget({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width ?? double.infinity, height ?? 0),
      painter: DashedLinePainter(),
    );
  }
}
class DashedLinePainter extends CustomPainter {
  final Paint _paint;

  DashedLinePainter() : _paint = Paint()
    ..color = AppColor.c142293.withOpacity(0.10)
    ..strokeWidth = 1.0
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    const double dashWidth = 5.0;
    const double dashSpace = 3.0;
    double startX = 0;

    while (startX < size.width) {
      // Draw a dash
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        _paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}