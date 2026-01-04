import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:keeper/core/widgets/ui/app_icon.dart";

class ProfileBtn extends StatelessWidget {
  final dynamic? icon;
  final String label;
  final VoidCallback? clickHandler;
  const ProfileBtn({
    super.key,

    required this.clickHandler,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: clickHandler,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 1),
              blurRadius: 2,
              color: Colors.grey.shade300,
            ),

            BoxShadow(
              offset: Offset(1, 1),
              blurRadius: 2,
              color: Colors.grey.shade300,
            ),
          ],
        ),
        child: Row(
          spacing: Get.width * 0.07,
          children: [
            AppIcon(icon, size: 25),
            Text(
              label,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            Spacer(),
            AppIcon(Icons.arrow_forward_ios, size: 25),
          ],
        ),
      ),
    );
  }
}
