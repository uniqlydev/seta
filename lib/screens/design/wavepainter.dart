import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue // Set the wave color here
      ..style = PaintingStyle.fill;

    final path = Path()
      ..lineTo(0, size.height * 0.5) // Start at the bottom-left corner
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.4, size.width * 0.5, size.height * 0.5) // First control point and endpoint of the curve
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.6, size.width, size.height * 0.5) // Second control point and endpoint of the curve
      ..lineTo(size.width, 0) // Finish at the bottom-right corner
      ..close();

    canvas.drawPath(path, paint);

    // Draw a white wave over the blue wave
    final whitePaint = Paint()
      ..color = Colors.white // Set the wave color here
      ..style = PaintingStyle.fill;

    final whitePath = Path()
      ..lineTo(0, size.height * 0.5) // Start at the bottom-left corner
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.6, size.width * 0.5, size.height * 0.5) // First control point and endpoint of the curve
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.4, size.width, size.height * 0.5) // Second control point and endpoint of the curve
      ..lineTo(size.width, 0) // Finish at the bottom-right corner
      ..close();

    canvas.drawPath(whitePath, whitePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
