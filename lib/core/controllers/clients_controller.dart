import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:keeper/constants/utils.dart';

class ClientsController extends GetxController {
  var client = <String, dynamic>{}.obs;
  var loading = false.obs;
  final RxList<Map<String, dynamic>> clients = <Map<String, dynamic>>[].obs;
  @override
  void onReady() {
    super.onReady();
    if (Get.currentRoute == AppRoutes.clients) {
      getClients();
    }
  }

  var errorMessage = ''.obs;
  var box = Hive.box("Clients");
  void addClient() async {
    // Check if all fields are filled (basic validation)
    if (client['name'] == null ||
        client['address'] == null ||
        client['email'] == null ||
        client['phone'] == null) {
      Get.snackbar(
        "Error",
        "All fields must be filled",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: Icon(HugeIcons.strokeRoundedDanger, color: Colors.white),
      );
      return;
    }

    loading.value = true;

    // Get existing clients from Hive
    var cls = await box.get("Clients");
    List<Map<String, dynamic>> currentClients = [];

    if (cls != null && cls != "") {
      currentClients = List<Map<String, dynamic>>.from(jsonDecode(cls));
    }

    // Add new client
    currentClients.add(client);

    // Save back to Hive
    await box.put("Clients", jsonEncode(currentClients));

    // Update observable list in memory
    clients.value = currentClients;

    loading.value = false;

    Get.snackbar("Success", "Client added successfully");
  }

  void getClients() async {
    final cls = await box.get("Clients");

    if (cls != null && cls != "") {
      try {
        final decoded = List<Map<String, dynamic>>.from(jsonDecode(cls));
        clients.value = decoded;
        errorMessage.value = "";
      } catch (e) {
        errorMessage.value = "Error loading clients";
        debugPrint("Get Clients error: $e");
      }
    } else {
      clients.clear();
      errorMessage.value = "You haven't added or saved any clients yet.";
    }
  }

  /// Remove client by index or custom ID (optional)
  void removeClient(int index) async {
    final cls = await box.get("Clients");

    if (cls != null && cls != "") {
      try {
        final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(
          jsonDecode(cls),
        );
        if (index >= 0 && index < data.length) {
          data.removeAt(index);
          await box.put("Clients", jsonEncode(data));
          clients.value = data;
          Get.snackbar("Removed", "Client removed successfully");
        } else {
          Get.snackbar("Error", "Invalid client index");
        }
      } catch (e) {
        debugPrint("Remove client error: $e");
        Get.snackbar("Error", "Failed to remove client");
      }
    }
  }

  void getClient(int index) async {
    final cls = await box.get("Clients");

    if (cls != null && cls != "") {
      try {
        final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(
          jsonDecode(cls),
        );
        client.value = data[index];
      } catch (e) {
        Get.snackbar("Error", "Unable to get client");
      }
    }
  }

  void updateField(String key, dynamic value) {
    client[key] = value;
  }
}
