import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:keeper/constants/utils.dart';
import 'package:keeper/core/controllers/clients_controller.dart';
import 'package:keeper/core/controllers/invoices_controller.dart';
import 'package:keeper/pages/home/screens/addClient/widgets/Input.dart';
import 'package:keeper/pages/home/screens/invoice_details.dart';
import 'package:keeper/pages/home/screens/invoices/widgets/invoice_date_selector.dart';
import 'package:keeper/pages/home/screens/invoices/widgets/invoice_table.dart';
import "package:keeper/core/widgets/ui/app_icon.dart";

class CreateInvoiceModal extends StatelessWidget {
  CreateInvoiceModal({super.key});
  final InvoicesController controller = Get.put(InvoicesController());
  final ClientsController clientCtrl = Get.put(ClientsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            padding: EdgeInsets.all(2),
            margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Color(0xFF1E90FF),
              borderRadius: BorderRadius.circular(7),
            ),
            child: AppIcon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        title: Text("Create New Invoice"),
        backgroundColor: Colors.white,

        // iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 40, top: 20),
          child: Column(
            spacing: 10,
            children: [
              Row(
                children: [
                  Text(
                    "Invoice ID: #${controller.invoiceId.value}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  TextButton.icon(
                    onPressed: () {},

                    icon: AppIcon(HugeIcons.strokeRoundedShare01),
                    label: Text(
                      "Share Link",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Create a new invoice to bill your clients.",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.addClient);
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.white,
                            ),
                          ),
                          icon: AppIcon(
                            HugeIcons.strokeRoundedPlusSign,
                            color: Color(0xFF1E90FF),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.clients);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Lanhubs Man (lanhubs@gmail.com)",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Input(
                label: "Invoice Title",
                onChanged: (value) {
                  controller.invoiceTitle.value = value;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InvoiceDateSelector(
                    title: "Issued Date",
                    onDateSelected: () {
                      // Handle date selection
                    },
                    hasHandler: false,
                    selectedDate: DateTime.now(),
                  ),
                  InvoiceDateSelector(
                    title: "Due Date",
                    onDateSelected: () {
                      controller.selectDate(context);
                    },
                    hasHandler: true,
                    selectedDate: controller.selectedDate.value,
                  ),
                ],
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    padding: EdgeInsets.only(bottom: Get.height*0.05),
                    child: InvoiceTable(),
                  ),

                  Positioned(
                    right: Get.width * 0.3,
                    left: Get.width * 0.3,
                    bottom: -10,
                    child: GestureDetector(
                      onTap: () {
                        controller.addInvoice();
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color(0xFF1E90FF),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            AppIcon(Icons.add, color: Colors.white),
                            Text(
                              "Add Item",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Items: ${controller.items.length}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: AppIcon(
                            HugeIcons.strokeRoundedDelete03,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            controller.items.value = [];
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Amount",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          "₦${controller.totalAmount.value}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E90FF),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text(
                          "Status:",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () {

                                controller.showStatuses.value =
                                    !controller.showStatuses.value;
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                margin: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "Paid",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.green[500],
                                  ),
                                ),
                              ),
                            ),
                            if (controller.showStatuses.value)
                              Positioned(
                                right: 5,
                                bottom: 40,
                                width: Get.width * 0.4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    // color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade200,
                                        blurRadius: 2,
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    spacing: 5,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: ["Paid", "Unpaid", "Pending"].map(
                                      (item) {
                                        return GestureDetector(
                                          onTap: () {
                                            // Handle status change logic
                                            controller.status.value = item;
                                            controller.showStatuses.value =false;
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 10,
                                            ),
                                            margin: EdgeInsets.only(left: 10),
                                            decoration: BoxDecoration(
                                              color: item == "Paid"
                                                  ? Colors.green.shade100
                                                  : item == "Unpaid"
                                                  ? Colors.red.shade100
                                                  : Colors.orange.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              item,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: item == "Paid"
                                                    ? Colors.green
                                                    : item == "Unpaid"
                                                    ? Colors.red
                                                    : Colors.orange,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(
                    "Additional Notes",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),

                  TextFormField(
                    onChanged: (value) {
                      controller.invoiceDescription.value = value;
                    },
                    maxLines: null,
                    minLines: 3,
                    keyboardType: TextInputType.multiline,

                    decoration: InputDecoration(
                      hintText:
                          "Tell the client more in details about the invoice.....",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide(
                          color: Colors.grey.shade600,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ],
          ),
        );
      }),

      bottomSheet: Container(
        width: Get.width,
        height: 70,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          spacing: Get.width * 0.05,
          children: [
            TextButton(
              onPressed: () => Get.dialog(InvoiceDetails()),
              child: Text(
                "Preview",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1E90FF),
                ),
              ),
            ),
           
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  controller.saveInvoice();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Color(0xFF1E90FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Text(
                  "Create Invoice",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
