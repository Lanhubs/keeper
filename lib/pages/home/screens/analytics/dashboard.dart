import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:keeper/core/controllers/dashboard_controller.dart';
import 'package:keeper/pages/home/screens/analytics/widgets/creators.dart';
import 'package:keeper/pages/home/screens/home/widgets/analytics_card.dart';
import './widgets/cashflow_chart.dart';
import 'package:get/get.dart';
import "package:keeper/core/widgets/ui/app_icon.dart";

class Analytics extends StatelessWidget {
  const Analytics({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Analytics",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => controller.refreshData(),
            icon: const AppIcon(
              HugeIcons.strokeRoundedRefresh,
              size: 22,
              color: Color(0xFF1E90FF),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF1E90FF)),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshData,
          color: const Color(0xFF1E90FF),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
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
                          onTap: () => controller.changeIndex(0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: controller.tabIndex.value == 0
                                  ? Colors.white
                                  : Colors.transparent,
                              border: controller.tabIndex.value == 0
                                  ? Border.all(
                                      color: const Color(0xFF1E90FF),
                                      width: 2,
                                    )
                                  : null,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Overview",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: controller.tabIndex.value == 0
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.changeIndex(1),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: controller.tabIndex.value == 1
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(7),
                              border: controller.tabIndex.value == 1
                                  ? Border.all(
                                      color: const Color(0xFF1E90FF),
                                      width: 2,
                                    )
                                  : null,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Recent",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: controller.tabIndex.value == 1
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                IndexedStack(
                  index: controller.tabIndex.value,
                  sizing: StackFit.loose,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Cash Flow",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        CashflowChart(cashflowData: controller.cashflowData),
                        const SizedBox(height: 24),
                        const Creators(),
                        const SizedBox(height: 24),
                        const Text(
                          "Statistics",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        AnalyticsCard(
                          icon: HugeIcons.strokeRoundedInvoice02,
                          iconColor: Colors.orange,
                          title: "Total Invoices",
                          value: controller.totalInvoices.value.toString(),
                        ),
                        AnalyticsCard(
                          icon: HugeIcons.strokeRoundedMoney02,
                          iconColor: const Color(0xFF1E90FF),
                          title: "Total Amount",
                          value:
                              "₦${controller.formatAmount(controller.totalAmount.value)}",
                        ),
                        AnalyticsCard(
                          icon: HugeIcons.strokeRoundedMoneyBag01,
                          iconColor: Colors.green,
                          title: "Paid Amount",
                          value:
                              "₦${controller.formatAmount(controller.paidAmount.value)}",
                        ),
                        AnalyticsCard(
                          icon: HugeIcons.strokeRoundedMoneyRemove01,
                          iconColor: Colors.orange,
                          title: "Pending Amount",
                          value:
                              "₦${controller.formatAmount(controller.pendingAmount.value)}",
                        ),
                        AnalyticsCard(
                          icon: HugeIcons.strokeRoundedMoneyAdd02,
                          iconColor: Colors.red,
                          title: "Overdue Amount",
                          value:
                              "₦${controller.formatAmount(controller.overdueAmount.value)}",
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Recent Invoices",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (controller.recentInvoices.isEmpty)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(40.0),
                              child: Column(
                                children: [
                                  AppIcon(
                                    HugeIcons.strokeRoundedInvoice02,
                                    size: 60,
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No invoices yet',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          ...controller.recentInvoices.map((invoice) {
                            final items =
                                invoice['items'] as List<dynamic>? ?? [];
                            double total = 0;
                            for (var item in items) {
                              total += (item['subTotal'] ?? 0).toDouble();
                            }

                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        invoice['title'] ?? 'Untitled',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(
                                            invoice['status'],
                                          ).withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          (invoice['status'] ?? 'pending')
                                              .toString()
                                              .toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: _getStatusColor(
                                              invoice['status'],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        invoice['date'] ?? '-',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      Text(
                                        "₦${total.toStringAsFixed(2)}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1E90FF),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'paid':
        return Colors.green;
      case 'overdue':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}
