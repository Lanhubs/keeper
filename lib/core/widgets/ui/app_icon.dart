import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class AppIcon extends StatelessWidget {
  final dynamic iconSource;
  final double? size;
  final Color? color;
  final double? strokeWidth;
  final BlendMode? blendMode;

  const AppIcon(
    this.iconSource, {
    super.key,
    this.size = 24.0,
    this.color,
    this.strokeWidth,
    this.blendMode,
  });

  @override
  Widget build(BuildContext context) {
    if (iconSource is IconData) {
      return Icon(
        iconSource as IconData,
        size: size,
        color: color,
        blendMode: blendMode,
        weight: strokeWidth,
      );
    } else {
      // HugeIcons uses List<List<dynamic>> type
      return HugeIcon(
        icon: iconSource,
        size: size ?? 24.0,
        color: color ?? Colors.black,
        strokeWidth: strokeWidth ?? 1.5,
      );
    }
  }
}
