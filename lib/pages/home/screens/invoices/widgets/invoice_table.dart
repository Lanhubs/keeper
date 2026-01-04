import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:keeper/core/controllers/invoices_controller.dart';
import 'package:keeper/widgets/borderless_input.dart';
import "package:keeper/core/widgets/ui/app_icon.dart";

class InvoiceTable extends StatelessWidget {
  var controller = Get.put(InvoicesController());

  InvoiceTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Table(
        columnWidths: const {
          0: FlexColumnWidth(3),
          1: FlexColumnWidth(1.5),
          2: FlexColumnWidth(1.5),
          3: FlexColumnWidth(2),
        },
        border: TableBorder(
          horizontalInside: BorderSide(width: 1, color: Colors.grey.shade300),
          top: BorderSide(width: 1, color: Colors.grey.shade300),
          right: BorderSide(width: 1, color: Colors.grey.shade300),
          left: BorderSide(width: 1, color: Colors.grey.shade300),
          bottom: BorderSide(width: 1, color: Colors.grey.shade300),
          verticalInside: BorderSide.none,
        ),
        children: [
          TableRow(
            decoration: BoxDecoration(color: Colors.grey.shade200),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 8,
                ),
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 8,
                ),
                child: Text(
                  'Qty',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 8,
                ),
                child: Text(
                  'Price',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 8,
                ),
                child: Text(
                  'Sub Total',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),

          ...controller.items.asMap().entries.map((entry) {
            final item = entry.value;
            final index = entry.key;
            return TableRow(
              children: [
                SizedBox(
                  width: Get.width * 0.3,
                  // padding: const EdgeInsets.symmetric(
                  //   vertical: 10.0,
                  //   horizontal: 8,
                  // ),
                  child: BorderlessInput(
                    placeholder: "Item name:",
                    type: TextInputType.text,
                    onchanged: (value) {
                      controller.updateItemName(item, value, index);
                    },
                    width: Get.width * 0.4,
                  ),
                ),
                BorderlessInput(
                  type: TextInputType.number,
                  onchanged: (value) {
                    controller.updateItemQty(item, value, index);
                  },
                ),

                Row(
                  children: [
                    Text('₦'),
                    BorderlessInput(
                      type: TextInputType.number,
                      onchanged: (value) {
                        debugPrint("$value");
                        controller.updateItemAmount(item, value, index);
                      },
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 8,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '₦${item.subTotal}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.removeInvoice(index);
                        },
                        child: AppIcon(
                          HugeIcons.strokeRoundedDelete02,
                          color: Colors.red,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
