import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:keeper/core/controllers/profile_controller.dart';
import 'package:keeper/pages/home/screens/profile/widgets/profile_btn.dart';
import 'package:keeper/pages/home/screens/profile/widgets/edit_profile_modal.dart';
import "package:keeper/core/widgets/ui/app_icon.dart";

class Profile extends GetView {
  Profile({super.key});
  final controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(EditProfileModal());
            },
            icon: const AppIcon(
              HugeIcons.strokeRoundedEdit02,
              color: Color(0xFF1E90FF),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Obx(
                    () => Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1E90FF), Color(0xFF00BFFF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1E90FF).withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          controller.getInitials(),
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => Text(
                      controller.userName.value,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Obx(
                    () => Text(
                      controller.userEmail.value,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => controller.businessName.value.isNotEmpty
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E90FF).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              controller.businessName.value,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF1E90FF),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Business Information',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => _buildInfoRow(
                      HugeIcons.strokeRoundedCall,
                      'Phone',
                      controller.phoneNumber.value.isEmpty
                          ? 'Not set'
                          : controller.phoneNumber.value,
                    ),
                  ),
                  const Divider(height: 24),
                  Obx(
                    () => _buildInfoRow(
                      HugeIcons.strokeRoundedLocation01,
                      'Address',
                      controller.address.value.isEmpty
                          ? 'Not set'
                          : controller.address.value,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ProfileBtn(
                    clickHandler: () {},
                    label: "Account Settings",
                    icon: HugeIcons.strokeRoundedUserSettings01,
                  ),
                  const SizedBox(height: 10),
                  ProfileBtn(
                    clickHandler: () {},
                    label: "Privacy Policy",
                    icon: HugeIcons.strokeRoundedShield01,
                  ),
                  const SizedBox(height: 10),
                  ProfileBtn(
                    clickHandler: () {},
                    label: "Terms of Service",
                    icon: HugeIcons.strokeRoundedLegalDocument02,
                  ),
                  const SizedBox(height: 10),
                  ProfileBtn(
                    clickHandler: () {},
                    label: "Help & Support",
                    icon: HugeIcons.strokeRoundedHelpSquare,
                  ),
                  const SizedBox(height: 10),
                  ProfileBtn(
                    clickHandler: () {
                      _showOptimizeStorageDialog(context);
                    },
                    label: "Optimize Storage",
                    icon: HugeIcons.strokeRoundedCleaningBucket,
                  ),
                  const SizedBox(height: 10),
                  ProfileBtn(
                    clickHandler: () {
                      _showClearDataDialog(context);
                    },
                    label: "Clear All Data",
                    icon: HugeIcons.strokeRoundedDelete02,
                    isDestructive: true,
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      _showLogoutDialog(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.red.shade50,
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const AppIcon(
                            Icons.logout_outlined,
                            size: 22,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            "Log Out",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(dynamic icon, String label, String value) {
    return Row(
      children: [
        AppIcon(icon, size: 20, color: Colors.grey.shade600),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Log Out', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showClearDataDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('Clear All Data'),
        content: const Text(
          'This will delete all invoices, clients, and settings. This action cannot be undone.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              await controller.clearData();
              Get.back();
              Get.snackbar(
                'Success',
                'All data has been cleared',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
            child: const Text(
              'Clear Data',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showOptimizeStorageDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('Optimize Storage'),
        content: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Current storage usage:'),
              const SizedBox(height: 12),
              Text('Invoices: ${controller.storageStats['invoices'] ?? 0}'),
              Text('Clients: ${controller.storageStats['clients'] ?? 0}'),
              const SizedBox(height: 12),
              const Text(
                'This will remove old data (older than 1 year) and compact the database.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              await controller.optimizeStorage();
              Get.back();
              Get.snackbar(
                'Success',
                'Storage optimized successfully',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
            child: const Text('Optimize'),
          ),
        ],
      ),
    );
  }
}
