import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:keeper/core/controllers/dashboard_controller.dart';
import 'package:keeper/pages/home/screens/analytics/widgets/creators.dart';
import 'package:keeper/pages/home/screens/home/widgets/analytics_card.dart';
import 'package:keeper/pages/home/screens/home/widgets/invoice_card.dart';
import './widgets/cashflow_chart.dart';
import 'package:get/get.dart';
import "package:keeper/core/widgets/ui/app_icon.dart";


class Analytics extends StatelessWidget {
  Analytics({super.key});
  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: AppIcon(HugeIcons.strokeRoundedMenu01, size: 25),
        ),
        title: Text(
          "Dashboard",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Obx(
         () {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
          
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.changeIndex(0);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color:controller.tabIndex.value==0? Colors.white: Colors.grey,
                              border:  controller.tabIndex.value == 0
                                  ? BoxBorder.all(
                                      color: Color(0xFF1E90FF),
                                      width: 1,
                                    )
                                  : null,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Money in/Out",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.changeIndex(1),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: controller.tabIndex.value == 1
                                  ? Colors.white
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                              border: controller.tabIndex.value == 1
                                  ? BoxBorder.all(
                                      color: Color(0xFF1E90FF),
                                      width: 1,
                                    )
                                  : null,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Generals",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                IndexedStack(
                  index: controller.tabIndex.value,
                  children: [
                    Column(
                      spacing: 15,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cash Flow",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CashflowChart(),
                        Row(
                          children: [
                            Text(
                              "Dashboard",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
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
          
                        Creators(),
                        AnalyticsCard(
                          icon: HugeIcons.strokeRoundedInvoice02,
                          iconColor: Colors.orange,
                          title: "Total Invoices",
                          value: "5",
                        ),
          
                        AnalyticsCard(
                          icon: HugeIcons.strokeRoundedMoneySend01,
                          iconColor: Colors.lightGreenAccent,
                          title: "Total Amount",
                          value: "₦1000",
                        ),
                        AnalyticsCard(
                          icon: HugeIcons.strokeRoundedMoneyBag01,
                          iconColor: Colors.teal,
                          title: "Paid Amount",
                          value: "₦800",
                        ),
                        AnalyticsCard(
                          icon: HugeIcons.strokeRoundedMoneyRemove01,
                          iconColor: Colors.green,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Invoices",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
          
                        ...[1, 2].map<Widget>((item) {
                          return InvoiceCard(
                            showDivider: false,
                            width: Get.width - 40,
                          );
                        }).toList(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
