import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keeper/core/helpers/storage_helper.dart';

class ProfileController extends GetxController {
  final box = Hive.box("Settings");

  final RxString userName = ''.obs;
  final RxString userEmail = ''.obs;
  final RxString businessName = ''.obs;
  final RxString phoneNumber = ''.obs;
  final RxString address = ''.obs;
  final RxMap<String, int> storageStats = <String, int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
    loadStorageStats();
  }

  void loadProfile() {
    userName.value = box.get('userName', defaultValue: 'User Name');
    userEmail.value = box.get('userEmail', defaultValue: 'user@example.com');
    businessName.value = box.get('businessName', defaultValue: 'Business Name');
    phoneNumber.value = box.get('phoneNumber', defaultValue: '');
    address.value = box.get('address', defaultValue: '');
  }

  Future<void> loadStorageStats() async {
    storageStats.value = await StorageHelper.getStorageStats();
  }

  Future<void> optimizeStorage() async {
    await StorageHelper.optimizeStorage();
    await loadStorageStats();
  }

  Future<void> updateProfile({
    String? name,
    String? email,
    String? business,
    String? phone,
    String? addr,
  }) async {
    if (name != null) {
      userName.value = name;
      await box.put('userName', name);
    }
    if (email != null) {
      userEmail.value = email;
      await box.put('userEmail', email);
    }
    if (business != null) {
      businessName.value = business;
      await box.put('businessName', business);
    }
    if (phone != null) {
      phoneNumber.value = phone;
      await box.put('phoneNumber', phone);
    }
    if (addr != null) {
      address.value = addr;
      await box.put('address', addr);
    }
  }

  String getInitials() {
    if (userName.value.isEmpty) return 'U';
    final parts = userName.value.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return userName.value[0].toUpperCase();
  }

  Future<void> clearData() async {
    await box.clear();
    final invoicesBox = Hive.box("Invoices");
    await invoicesBox.clear();
    final clientsBox = Hive.box("Clients");
    await clientsBox.clear();
    loadProfile();
  }
}
