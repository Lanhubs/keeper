import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:keeper/constants/utils.dart';
import "package:keeper/core/widgets/ui/app_icon.dart";
import 'package:keeper/core/controllers/invoices_list_controller.dart';
import 'package:keeper/pages/home/screens/invoices/widgets/create_invoice_modal.dart';
import 'package:keeper/widgets/general_invoices_card.dart';
import 'package:keeper/widgets/search_input.dart';

class Invoices extends GetView<InvoicesListController> {
  const Invoices({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller if not already initialized
    Get.put(InvoicesListController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Invoices"),
        actionsPadding: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Get.to(
                CreateInvoiceModal(),
                transition: Transition.downToUp,
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastLinearToSlowEaseIn,
              )?.then((_) => controller.refreshData());
            },
            label: const Text(
              "Create Invoice",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            icon: const AppIcon(
              HugeIcons.strokeRoundedPlusSign,
              size: 20,
              color: Colors.white,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E90FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
        ],
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
                          controller.selectedCategory.value ==
                          categoryKeys[index];
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
                SearchInput(
                  hintText: "Search Invoices",
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
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40.0),
                        child: CircularProgressIndicator(
                          color: Color(0xFF1E90FF),
                        ),
                      ),
                    );
                  }

                  if (controller.filteredInvoices.isEmpty) {
                    return Center(
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
                              'No invoices found',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Create your first invoice to get started',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: controller.filteredInvoices.map((invoice) {
                      final total = controller.calculateInvoiceTotal(invoice);
                      final invoiceId =
                          invoice['id']?.toString() ??
                          DateTime.now().millisecondsSinceEpoch.toString();

                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.invoicePreview,
                            arguments: invoiceId,
                          );
                        },
                        child: GeneralInvoicesCard(
                          height: Get.height * 0.18,
                          width: Get.width - 40,
                          title: invoice['title']?.toString() ?? 'Untitled',
                          invoiceId: invoiceId,
                          amount: total.toStringAsFixed(2),
                          date:
                              invoice['date']?.toString() ??
                              DateTime.now().toString().split(' ')[0],
                          status: invoice['status']?.toString() ?? 'pending',
                        ),
                      );
                    }).toList(),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(
            AppRoutes.createInvoice,
          )?.then((_) => controller.refreshData());
        },
        heroTag: "add_invoice",
        backgroundColor: const Color(0xFF1E90FF),
        child: const AppIcon(Icons.add, size: 25, color: Colors.white),
      ),
    );
  }
}
