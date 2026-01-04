import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:keeper/constants/utils.dart';
import 'package:keeper/pages/home/screens/home/widgets/invoice_card.dart';
import "package:keeper/core/widgets/ui/app_icon.dart";

import 'package:keeper/pages/home/screens/invoices/widgets/create_invoice_modal.dart';
import 'package:keeper/widgets/general_invoices_card.dart';
import 'package:keeper/widgets/search_input.dart';

class Invoices extends StatelessWidget {
  const Invoices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        backgroundColor: Colors.white,

        title: Text("Invoices"),
        actionsPadding: EdgeInsets.only(right: 20, top: 10, bottom: 10),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Get.dialog(
                CreateInvoiceModal(),
                useSafeArea: true,
                transitionCurve: Curves.fastLinearToSlowEaseIn,
                transitionDuration: Duration(milliseconds: 300),
              );
            },
            label: Text(
              "Create Invoice",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            icon: AppIcon(
              HugeIcons.strokeRoundedPlusSign,
              size: 20,
              color: Colors.white,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF1E90FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            spacing: 10,
            children: [
              StatefulBuilder(
                builder: (context, setState) {
                  int selectedIndex = 0;
                  final categories = ["Paid (05)", "Pending", "Overdue"];
                  return Row(
                    children: List.generate(categories.length, (index) {
                      final isSelected = selectedIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              fontSize: 14,
                              color: isSelected
                                  ? Color(0xFF1E90FF)
                                  : Colors.grey,
                              decoration: isSelected
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                              decorationColor: Color(0xFF1E90FF),

                              fontWeight: isSelected
                                  ? FontWeight.w500
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
              SizedBox(height: 10),
              SearchInput(
                hintText: "Search Invoices",
                onChanged: (value) {
                  // Handle search input changes
                },
              ),
              SizedBox(height: 10),

              GeneralInvoicesCard(
                height: Get.height * 0.18,
                width: Get.width - 40,
                title: "Cement Supply",
                subtitle: "Client Name",
                amount: "100.00",
                date: "2023-10-01",
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Get.to(CreateInvoiceModal(), transition: Transition.downToUp);
          Get.toNamed(AppRoutes.createInvoice);
        },
        heroTag: "add_invoice",
        backgroundColor: Color(0xFF1E90FF),
        child: AppIcon(Icons.add, size: 25, color: Colors.white),
      ),
    );
  }
}
