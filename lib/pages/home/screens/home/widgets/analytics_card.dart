import 'package:flutter/material.dart';
import "package:keeper/core/widgets/ui/app_icon.dart";

class AnalyticsCard extends StatelessWidget {
  final String? title;
  final String? value;
  final String? subtitle;
  final dynamic? icon;
  final Color? iconColor;

  const AnalyticsCard({
    super.key,
    this.title,
    this.value,
    this.subtitle,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 1,
            offset: Offset(1, 0),
          ),
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 1,
            offset: Offset(1, 0),
          ),
        ],
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title ?? 'Analytics',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              Text(
                value ?? '0',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),

              Text(
                subtitle ?? 'Subtitle here',
                style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
              ),
            ],
          ),

          AppIcon(
            icon ?? Icons.analytics,
            color: iconColor ?? Colors.blue,
            size: 35,
          ),
        ],
      ),
    );
  }
}
