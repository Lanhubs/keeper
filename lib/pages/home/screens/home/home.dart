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
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 20,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "You are welcome",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 2),
            const Text(
              "Lanhubs",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const AppIcon(
              HugeIcons.strokeRoundedNotification03,
              size: 30,
              color: Colors.grey,
            ),
          ),
        ],
        actionsPadding: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
      ),
      body: RefreshIndicator(
        onRefresh: controller.refreshData,
        color: const Color(0xFF1E90FF),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                SearchInput(
                  onChanged: (value) {
                    controller.searchInvoices(value);
                  },
                  onFilterApply: (status, dateRange) {
                    if (status != null) {
                      controller.filterByCategory(status);
                    }
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        controller.changeIndex(2); // Navigate to invoices tab
                      },
                      child: const Text(
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
                const SizedBox(height: 10),
                _buildCategoriesSection(),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      "Dashboard",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        controller.changeIndex(1); // Navigate to analytics tab
                      },
                      child: const Text(
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
                _buildDashboardSection(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: ExpandableFab(),
    );
  }

  Widget _buildCategoriesSection() {
    return Container(
      height: Get.height * 0.26,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            final categories = [
              'Paid (${controller.paidCount.value.toString().padLeft(2, '0')})',
              'Pending (${controller.pendingCount.value.toString().padLeft(2, '0')})',
              'Overdue (${controller.overdueCount.value.toString().padLeft(2, '0')})',
            ];
            final categoryKeys = ['Paid', 'Pending', 'Overdue'];

            return Row(
              children: List.generate(categories.length, (index) {
                final isSelected =
                    controller.selectedCategory.value == categoryKeys[index];
                return GestureDetector(
                  onTap: () {
                    controller.filterByCategory(categoryKeys[index]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        fontSize: 14,
                        color: isSelected
                            ? const Color(0xFF1E90FF)
                            : Colors.grey,
                        decoration: isSelected
                            ? TextDecoration.underline
                            : TextDecoration.none,
                        decorationColor: const Color(0xFF1E90FF),
                        fontWeight: isSelected
                            ? FontWeight.w500
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFF1E90FF)),
                );
              }

              if (controller.filteredInvoices.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppIcon(
                        HugeIcons.strokeRoundedInvoice02,
                        size: 40,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'No invoices found',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.hardEdge,
                child: Row(
                  children: controller.filteredInvoices.take(6).map((invoice) {
                    final items = invoice['items'] as List<dynamic>? ?? [];
                    double total = 0;
                    for (var item in items) {
                      total += (item['subTotal'] ?? 0).toDouble();
                    }

                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InvoiceCard(
                        height: Get.height * 0.14,
                        showDivider: false,
                        invoiceId: invoice['id']?.toString() ?? '0',
                        title: invoice['title']?.toString() ?? 'Untitled',
                        amount: total.toStringAsFixed(0),
                        date: invoice['date']?.toString(),
                        status: invoice['status']?.toString() ?? 'pending',
                      ),
                    );
                  }).toList(),
                ),
              );
            }),
          ),
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () {
                  controller.changeIndex(2); // Navigate to invoices tab
                },
                child: const Text(
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
    );
  }

  Widget _buildDashboardSection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              value: "₦${controller.formatAmount(controller.paidAmount.value)}",
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
      ),
    );
  }
}
