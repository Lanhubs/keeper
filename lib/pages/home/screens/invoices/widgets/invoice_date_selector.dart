import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import "package:keeper/core/widgets/ui/app_icon.dart";

class InvoiceDateSelector extends StatelessWidget {
  final String? title;
  final VoidCallback? onDateSelected;
  final DateTime? selectedDate;
  bool hasHandler = false;
  InvoiceDateSelector({
    super.key,
    this.title,
    this.onDateSelected,
    this.selectedDate,
    this.hasHandler = true,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        Text(
          title ?? "Issued Date",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        InkWell(
          onTap: onDateSelected ?? () {},
          child: Container(
            width: Get.width * 0.43,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border: BoxBorder.all(color: Colors.grey.shade300),
            ),
            child: Row(
              spacing: 20,
              children: [
                AppIcon(HugeIcons.strokeRoundedCalendar02, color: Colors.grey),
                Text(
                  hasHandler == false
                      ? '${currentDate.day}-${currentDate.month}-${currentDate.year}'
                      : "${selectedDate?.day}-${selectedDate?.month}-${selectedDate?.year}",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
