import 'package:flutter/material.dart';
import "package:keeper/core/widgets/ui/app_icon.dart";

class ProfileBtn extends StatelessWidget {
  final dynamic icon;
  final String label;
  final VoidCallback? clickHandler;
  final bool isDestructive;

  const ProfileBtn({
    super.key,
    required this.clickHandler,
    required this.label,
    required this.icon,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: clickHandler,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 4,
              color: Colors.grey.shade200,
            ),
          ],
        ),
        child: Row(
          children: [
            AppIcon(
              icon,
              size: 22,
              color: isDestructive ? Colors.red : Colors.grey.shade700,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDestructive ? Colors.red : Colors.black87,
                ),
              ),
            ),
            AppIcon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
