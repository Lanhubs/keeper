import "package:flutter/material.dart";
import "package:hugeicons/hugeicons.dart";
import "package:keeper/core/widgets/ui/app_icon.dart";

class Creators extends StatelessWidget {
  const Creators({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionButton(
          icon: HugeIcons.strokeRoundedInvoice,
          color: Colors.orange,
          onTap: () {},
        ),
        _buildActionButton(
          icon: HugeIcons.strokeRoundedUserAdd01,
          color: Colors.lightGreen,
          onTap: () {},
        ),
        _buildActionButton(
          icon: HugeIcons.strokeRoundedMoneyAdd02,
          color: const Color(0xFF1E90FF),
          onTap: () {},
        ),
        _buildActionButton(
          icon: HugeIcons.strokeRoundedInvoice01,
          color: Colors.deepOrange,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required dynamic icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: color),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: AppIcon(icon, size: 28, color: color),
      ),
    );
  }
}
