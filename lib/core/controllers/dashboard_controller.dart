import 'dart:convert';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DashboardController extends GetxController {
  final box = Hive.box("Invoices");

  final tabIndex = 0.obs;
  final RxBool isLoading = false.obs;

  // Invoice data
  final RxList<Map<String, dynamic>> allInvoices = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> recentInvoices =
      <Map<String, dynamic>>[].obs;

  // Dashboard stats
  final RxInt totalInvoices = 0.obs;
  final RxDouble totalAmount = 0.0.obs;
  final RxDouble paidAmount = 0.0.obs;
  final RxDouble pendingAmount = 0.0.obs;
  final RxDouble overdueAmount = 0.0.obs;

  // Monthly cashflow data
  final RxList<CashflowData> cashflowData = <CashflowData>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAnalyticsData();
  }

  void changeIndex(int index) {
    tabIndex.value = index;
  }

  Future<void> loadAnalyticsData() async {
    isLoading.value = true;
    try {
      final rawData = box.get('invoicesList');
      if (rawData != null) {
        if (rawData is String) {
          final List<dynamic> decoded = jsonDecode(rawData);
          allInvoices.value = decoded
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
        } else if (rawData is List) {
          allInvoices.value = rawData
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
        }
      } else {
        allInvoices.value = [];
      }

      _calculateStats();
      _calculateCashflow();
      _getRecentInvoices();
    } catch (e) {
      print('Error loading analytics data: $e');
      allInvoices.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  void _calculateStats() {
    totalInvoices.value = allInvoices.length;

    double total = 0;
    double paid = 0;
    double pending = 0;
    double overdue = 0;

    for (var invoice in allInvoices) {
      final items = invoice['items'] as List<dynamic>? ?? [];
      double invoiceTotal = 0;

      for (var item in items) {
        final subTotal = (item['subTotal'] ?? 0).toDouble();
        invoiceTotal += subTotal;
      }

      total += invoiceTotal;

      final status = (invoice['status'] ?? 'pending').toString().toLowerCase();
      switch (status) {
        case 'paid':
          paid += invoiceTotal;
          break;
        case 'overdue':
          overdue += invoiceTotal;
          break;
        default:
          pending += invoiceTotal;
      }
    }

    totalAmount.value = total;
    paidAmount.value = paid;
    pendingAmount.value = pending;
    overdueAmount.value = overdue;
  }

  void _calculateCashflow() {
    // Initialize monthly data
    final Map<int, CashflowData> monthlyData = {};
    for (int i = 1; i <= 12; i++) {
      monthlyData[i] = CashflowData(_getMonthName(i), 0, 0);
    }

    // Aggregate invoice data by month
    for (var invoice in allInvoices) {
      final dateStr = invoice['date']?.toString();
      if (dateStr != null) {
        try {
          final date = DateTime.parse(dateStr);
          final month = date.month;

          final items = invoice['items'] as List<dynamic>? ?? [];
          double invoiceTotal = 0;
          for (var item in items) {
            invoiceTotal += (item['subTotal'] ?? 0).toDouble();
          }

          final status = (invoice['status'] ?? 'pending')
              .toString()
              .toLowerCase();
          if (status == 'paid') {
            monthlyData[month]!.moneyIn += invoiceTotal;
          } else {
            monthlyData[month]!.moneyOut += invoiceTotal;
          }
        } catch (e) {
          print('Error parsing date: $e');
        }
      }
    }

    cashflowData.value = monthlyData.values.toList();
  }

  void _getRecentInvoices() {
    // Sort by creation date and get the 5 most recent
    final sorted = List<Map<String, dynamic>>.from(allInvoices);
    sorted.sort((a, b) {
      final dateA = a['createdAt']?.toString() ?? '';
      final dateB = b['createdAt']?.toString() ?? '';
      return dateB.compareTo(dateA);
    });
    recentInvoices.value = sorted.take(5).toList();
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  String formatAmount(double amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    }
    return amount.toStringAsFixed(0);
  }

  Future<void> refreshData() async {
    await loadAnalyticsData();
  }
}

class CashflowData {
  CashflowData(this.month, this.moneyIn, this.moneyOut);
  final String month;
  double moneyIn;
  double moneyOut;
}
