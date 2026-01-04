import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class InvoicesListController extends GetxController {
  final box = Hive.box("Invoices");

  final RxList<Map<String, dynamic>> allInvoices = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> filteredInvoices =
      <Map<String, dynamic>>[].obs;
  final RxString selectedCategory = 'Paid'.obs;
  final RxString searchQuery = ''.obs;
  final RxBool isLoading = false.obs;

  // Category counts
  final RxInt paidCount = 0.obs;
  final RxInt pendingCount = 0.obs;
  final RxInt overdueCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadInvoices();
  }

  @override
  void onReady() {
    super.onReady();
    // Refresh whenever the controller becomes active
    ever(_refreshTrigger, (_) => loadInvoices());
  }

  final RxInt _refreshTrigger = 0.obs;

  void triggerRefresh() {
    _refreshTrigger.value++;
  }

  Future<void> loadInvoices() async {
    isLoading.value = true;
    try {
      final rawData = box.get('invoicesList');
      if (rawData != null) {
        if (rawData is String) {
          // Handle old format (JSON string)
          final List<dynamic> decoded = jsonDecode(rawData);
          allInvoices.value = decoded
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
        } else if (rawData is List) {
          // Handle new format (direct list)
          allInvoices.value = rawData
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
        }
      } else {
        allInvoices.value = [];
      }
      _calculateCounts();
      filterByCategory(selectedCategory.value);
    } catch (e) {
      debugPrint('Error loading invoices: $e');
      allInvoices.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  void _calculateCounts() {
    int paid = 0;
    int pending = 0;
    int overdue = 0;

    for (var invoice in allInvoices) {
      final status = (invoice['status'] ?? 'pending').toString().toLowerCase();
      switch (status) {
        case 'paid':
          paid++;
          break;
        case 'overdue':
          overdue++;
          break;
        default:
          pending++;
      }
    }

    paidCount.value = paid;
    pendingCount.value = pending;
    overdueCount.value = overdue;
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;

    if (category.toLowerCase() == 'all') {
      filteredInvoices.value = List.from(allInvoices);
    } else {
      filteredInvoices.value = allInvoices.where((invoice) {
        final status = (invoice['status'] ?? 'pending')
            .toString()
            .toLowerCase();
        return status == category.toLowerCase();
      }).toList();
    }

    if (searchQuery.value.isNotEmpty) {
      searchInvoices(searchQuery.value);
    }
  }

  void searchInvoices(String query) {
    searchQuery.value = query;

    if (query.isEmpty) {
      filterByCategory(selectedCategory.value);
      return;
    }

    final lowerQuery = query.toLowerCase();
    filteredInvoices.value = allInvoices.where((invoice) {
      final title = (invoice['title'] ?? '').toString().toLowerCase();
      final id = (invoice['id'] ?? '').toString().toLowerCase();

      final matchesSearch =
          title.contains(lowerQuery) || id.contains(lowerQuery);

      if (selectedCategory.value.toLowerCase() == 'all') {
        return matchesSearch;
      }

      final status = (invoice['status'] ?? 'pending').toString().toLowerCase();
      return matchesSearch && status == selectedCategory.value.toLowerCase();
    }).toList();
  }

  Future<void> refreshData() async {
    await loadInvoices();
  }

  double calculateInvoiceTotal(Map<String, dynamic> invoice) {
    final items = invoice['items'] as List<dynamic>? ?? [];
    double total = 0;
    for (var item in items) {
      total += (item['subTotal'] ?? 0).toDouble();
    }
    return total;
  }
}
