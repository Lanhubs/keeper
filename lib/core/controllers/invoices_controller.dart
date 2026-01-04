import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';

import 'package:keeper/constants/utils.dart';
import 'package:keeper/core/helpers/toast_helper.dart';

class InvoicesController extends GetxController {
  final box = Hive.box("keeperBox");
  final selectedDate = DateTime.now().obs;

  final showStatuses = false.obs;
  var status = "".obs;
  var errorMessage = "".obs;
  final RxDouble totalAmount = 0.0.obs;
  final RxList<Invoice> items = <Invoice>[].obs;
  final RxString invoiceId = ''.obs;
  final RxString invoiceTitle = ''.obs;
  final RxString invoiceDescription = ''.obs;
  var invoiceAmount = 0.0.obs;
  final RxInt invoiceQuantity = 0.obs;
  final RxDouble invoiceSubTotal = 0.0.obs;
  final RxMap<String, dynamic> customer = <String, dynamic>{}.obs;
  final RxMap<String, dynamic> invoiceData = <String, dynamic>{}.obs;
  final invoice = {}.obs;
  final invoices = [].obs;
  // void onReady() {
  //   super.onReady();
  //   // Load existing invoices if any
  //   final data = box.get('Invoices');
  //   if (data != null) {
  //     final List<dynamic> invoiceList = jsonDecode(data);
  //     items.addAll(
  //       invoiceList
  //           .map(
  //             (item) => Invoice(
  //               id: item['id'],
  //               status: item['status'] ?? '',
  //               title: item['title'],
  //               description: item['description'],
  //               amount: item['amount'],
  //               quantity: item['quantity'],
  //               subTotal: item['subTotal'] ?? 0.0,
  //             ),
  //           )
  //           .toList(),
  //     );
  //   }
  // }

  @override
  @override
  void onInit() {
    super.onInit();
    debugPrint('InvoicesController onInit called');
    if (Get.currentRoute == AppRoutes.createInvoice) {
      debugPrint(DateTime.now().millisecondsSinceEpoch.toString());
      invoiceId.value = DateTime.now().millisecondsSinceEpoch.toString();

      if (items.isEmpty) {
        addInvoice(); // Ensure at least one invoice on start
      }
    }
  }

  @override
  void onClose() {
    items.clear();
    super.onClose();
  }

  void addInvoice() {
    items.add(
      Invoice(
        id: "",
        title: '',
        description: '',
        amount: 0.0,
        quantity: 0,
        status: "",
      ),
    );
  }

  void removeInvoice(int index) {
    if (!items.contains(items[index])) return;
    items.remove(items[index]);
    update();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picedkDate = await showDatePicker(
      context: context,
      firstDate: selectedDate.value,
      lastDate: DateTime(2030),
    );
    if (picedkDate != null) {
      selectedDate.value = picedkDate;

      // Get.back();
    }
  }

  void clearInvoices() {
    items.clear();
    update();
  }

  void updateItemAmount(Invoice item, String value, int index) {
    if (value.isEmpty) return;
    final double? amount = double.tryParse(value);
    if (amount != null) {
      items[index] = Invoice(
        status: item.status,
        id: item.id,
        title: item.title,
        description: item.description,
        amount: amount,
        quantity: item.quantity,
        subTotal: item.amount * item.quantity!,
      );
      totalAmount.value = items
          .map((item) => item.subTotal)
          .reduce((a, b) => a! + b!)!;

      update();
    }
  }

  void updateItemName(Invoice item, String value, index) {
    if (value.isEmpty) return;
    items[index] = Invoice(
      status: item.status,
      id: item.id,
      title: value,
      description: item.description,
      amount: item.amount,
      quantity: item.quantity,
    );
    update();
  }

  void updateItemQty(Invoice item, String value, index) {
    if (value.isEmpty) return;
    final int? quantity = int.tryParse(value);

    if (quantity != null) {
      items[index] = Invoice(
        id: item.id,
        title: item.title,
        description: item.description,
        amount: item.amount,
        subTotal: item.amount * item.quantity!,

        quantity: quantity,
        status: item.status,
      );
      update();
    }
  }

  Future<void> saveInvoice() async {
    if (items.isEmpty) {
      ToastHelper.showError("No invoices to save");
      return;
    }
    invoice.value = {
      "title": invoiceTitle,
      "note": invoiceDescription,
      "items": items.map((item) => item.toJson()).toList(),
    };

    final rawData = await box.get('Invoices');
    List<Map<String, dynamic>> data = [];
    if (rawData != null) {
      try {
        data = List<Map<String, dynamic>>.from(jsonDecode(rawData));
      } catch (e) {
        ToastHelper.showError("Invalid data format in storage");
      }
    }
    invoices.value = data.map((item) => item).toList();
    invoices.add(invoice);
    var storeData = jsonEncode(invoices);
    box.put("Invoices", storeData);
    if (await box.get('Invoices') != null) {
      ToastHelper.showSuccess("Invoice saved successfully");
    } else {
      ToastHelper.showError("Failed to save invoice");
    }
  }

  Future<void> previewInvoice() async {
    final data = await box.get('Invoices');

    invoiceData.value = data != null ? jsonDecode(data) : <String, dynamic>{};
  }
}

class Invoice {
  final String id;
  final String title;
  final String description;
  final double amount;
  final int? quantity;
  final double? subTotal;
  final String status;
  Invoice({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.quantity,
    this.subTotal = 0,
    required this.status,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'amount': amount,
      'quantity': quantity,
      'subTotal': subTotal,
      'status': status,
    };
  }
}
