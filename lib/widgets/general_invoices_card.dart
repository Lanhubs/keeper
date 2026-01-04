import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:keeper/core/widgets/ui/app_icon.dart";

class GeneralInvoicesCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? amount;
  final String? date;
  final double? width;
  final String? status;
  final double? height;
  final String? invoiceId;
  const GeneralInvoicesCard({
    super.key,
    this.status,
    this.invoiceId,
    this.height,
    this.title,
    this.width,
    this.subtitle,
    this.amount,
    this.date,
  });

  Color _getStatusColor() {
    switch (status?.toLowerCase()) {
      case 'paid':
        return Colors.green;
      case 'overdue':
        return Colors.red;
      case 'pending':
      default:
        return Colors.orange;
    }
  }

  Color _getStatusBgColor() {
    switch (status?.toLowerCase()) {
      case 'paid':
        return Colors.green.shade100;
      case 'overdue':
        return Colors.red.shade100;
      case 'pending':
      default:
        return Colors.orange.shade100;
    }
  }

  String _getStatusText() {
    switch (status?.toLowerCase()) {
      case 'paid':
        return 'Paid';
      case 'overdue':
        return 'Overdue';
      case 'pending':
      default:
        return 'Pending';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: width ?? Get.width * 0.65,
      height: height ?? Get.height * 0.15,
      margin: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Invoice ID: #${invoiceId ?? '0'}",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusBgColor(),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  _getStatusText(),
                  style: TextStyle(fontSize: 12, color: _getStatusColor()),
                ),
              ),
            ],
          ),
          Divider(color: Colors.grey.shade200, height: 20, thickness: 1.5),
          Text(
            title ?? 'Untitled',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(date ?? '-', style: TextStyle(fontSize: 14, color: Colors.grey)),
          SizedBox(height: 5),
          Divider(color: Colors.grey.shade200, height: 20, thickness: 1.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "₦${amount ?? '0'}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E90FF),
                ),
              ),
              GestureDetector(
                child: Row(
                  spacing: 5,
                  children: [
                    Text(
                      "View Details",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF1E90FF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppIcon(
                      Icons.arrow_forward_ios_sharp,
                      color: Color(0xFF1E90FF),
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
