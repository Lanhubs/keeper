import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:hugeicons/hugeicons.dart";
import 'package:keeper/core/controllers/home_controller.dart';
import 'package:keeper/pages/home/screens/home/widgets/analytics_card.dart';
import 'package:keeper/widgets/expandable_tab.dart';
import 'package:keeper/widgets/search_input.dart';
import './widgets/invoice_card.dart';
import "package:keeper/core/widgets/ui/app_icon.dart";

class Home extends GetView<HomeController> {
  Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        backgroundColor: Colors.white,

        titleSpacing: 20,

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 2,
          children: [
            Text(
              "You are welcome",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            Text(
              "Lanhubs",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: AppIcon(
              HugeIcons.strokeRoundedNotification03,
              size: 30,
              color: Colors.grey,
            ),
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 20, top: 10, bottom: 10),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            spacing: 10,
            children: [
              SearchInput(
                onChanged: (value) {
                  // Handle search input changes
                },
                onFilterTap: () {
                  // Handle filter tap
                },
              ),

              Row(
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "See all",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF1E90FF),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF1E90FF),
                      ),
                    ),
                  ),
                ],
              ),

              Container(
                height: Get.height * 0.26,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 10),

                decoration: BoxDecoration(
                  color: Color(0xFFF5F7FA),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.hardEdge,
                      child: Row(
                        spacing: 10,

                        children: List.generate(
                          6,
                          (index) => InvoiceCard(
                            height: Get.height * 0.14,
                            showDivider: false,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "See all",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF1E90FF),
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xFF1E90FF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    "Dashboard",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Preview",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF1E90FF),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF1E90FF),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F7FA),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    AnalyticsCard(
                      icon: HugeIcons.strokeRoundedInvoice02,
                      iconColor: Colors.orange,
                      title: "Total Invoices",
                      value: "5",
                    ),

                    AnalyticsCard(
                      icon: HugeIcons.strokeRoundedMoney02,
                      iconColor: Color(0xFF1E90FF),
                      title: "Total Amount",
                      value: "₦1000",
                    ),
                    AnalyticsCard(
                      icon: HugeIcons.strokeRoundedMoneyBag01,
                      iconColor: Color(0xFF1E90FF),
                      title: "Paid Amount",
                      value: "₦800",
                    ),
                    AnalyticsCard(
                      icon: HugeIcons.strokeRoundedMoneyRemove01,
                      iconColor: Color(0xFF1E90FF),
                      title: "Pending Amount",
                      value: "₦200",
                    ),

                    AnalyticsCard(
                      icon: HugeIcons.strokeRoundedMoneyAdd02,
                      iconColor: Color(0xFF1E90FF),
                      title: "Overdue Amount",
                      value: "₦150",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      floatingActionButton: ExpandableFab(),
    );
  }
}
