import 'package:flutter/material.dart';

class DashedLinePainter extends CustomPainter {
  DashedLinePainter({
    this.dashColor = Colors.grey,
    // ignore: unused_element
    this.dashWidth = 3,
    // ignore: unused_element
    this.dashSpace = 3,
    this.strokeWidth = 1,
  });
  final Color dashColor;
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;
  @override
  void paint(Canvas canvas, Size size) {
    double startX = 0;
    final paint = Paint()
      ..color = dashColor
      ..strokeWidth = strokeWidth;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
