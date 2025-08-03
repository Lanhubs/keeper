import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

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
        SizedBox(
          width: Get.width * 0.43,
          child: TextButton.icon(
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
                side: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            onPressed: onDateSelected ?? () {},
            label: Text(
              hasHandler == false
                  ? '${currentDate.day}-${currentDate.month}-${currentDate.year}'
                  : "${selectedDate?.day}-${selectedDate?.month}-${selectedDate?.year}",
              style: TextStyle(color: Colors.grey),
            ),
            icon: Icon(HugeIcons.strokeRoundedCalendar02, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
