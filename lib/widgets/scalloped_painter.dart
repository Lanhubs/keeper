import 'package:flutter/material.dart';
class ScallopedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    const radius = 10.0;
    final count = (size.width / (radius * 2)).floor();

    path.moveTo(0, 0);

    // Top edge
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);

    // Scalloped bottom
    for (int i = 0; i < count; i++) {
      final x = i * radius * 2;
      path.arcToPoint(
        Offset(x + radius * 2, 0),
        radius: Radius.circular(radius),
        clockwise: false,
      );
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}