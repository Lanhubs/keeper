import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:hugeicons/hugeicons.dart";
import "package:keeper/core/widgets/ui/app_icon.dart";

class Creators extends GetView {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: BoxBorder.all(width: 1.5, color: Colors.orange),
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
            ),
            child: AppIcon(
              HugeIcons.strokeRoundedInvoice,
              size: 35,
              color: Colors.orange,
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: BoxBorder.all(width: 1.5, color: Colors.lightGreen),
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
            ),
            child: AppIcon(
              HugeIcons.strokeRoundedUserAdd01,
              size: 30,
              color: Colors.lightGreen,
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: BoxBorder.all(width: 1.5, color: Color(0xFF1E90FF)),
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
            ),
            child: AppIcon(
              HugeIcons.strokeRoundedMoneyAdd02,
              size: 30,
              color: Color(0xFF1E90FF),
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: BoxBorder.all(width: 1.5, color: Colors.deepOrange),
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
            ),
            child: AppIcon(
              HugeIcons.strokeRoundedInvoice01,
              size: 30,
              color: Colors.deepOrangeAccent,
            ),
          ),
        ),
      ],
    );
  }
}
