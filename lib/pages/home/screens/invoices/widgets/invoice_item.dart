import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import "package:keeper/core/widgets/ui/app_icon.dart";

class InvoiceItem extends StatelessWidget {
  final String? title;
  final String? qty;
  final String? amount;
  final String? date;
  final double? width;
  final double? height;
  final int? id;
  final TextInputType? type;
  final VoidCallback? onDelete;
  final void Function(String)? onChangeName;
  final void Function(String)? onChangeQty;
  final void Function(String)? onChangeAmount;

  const InvoiceItem({
    super.key,
    this.id = 1,
    this.onDelete,
    this.onChangeName,
    this.onChangeQty,
    this.onChangeAmount,
    this.height,
    this.title,
    this.width,
    this.qty,
    this.amount,
    this.date,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(vertical: 5),
      height: Get.height * 0.12,
      decoration: BoxDecoration(
        border: BoxBorder.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "0${id != null ? id! + 1 : 1}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Column(
              // spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  keyboardType: type,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter description",
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14,
                    ),
                  ),
                ),

                SizedBox(
                  // color: Colors.green,
                  width: Get.width * 0.4,
                  child: Row(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Text(
                        "Quantity:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          onChanged: onChangeQty,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,

                            hintText: "qty",
                            contentPadding: EdgeInsets.all(0),
                            hintStyle: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: Get.width * 0.15,
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "₦0.00",
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: onDelete,
                child: AppIcon(
                  HugeIcons.strokeRoundedDelete03,
                  color: Colors.red,
                  size: 25,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
