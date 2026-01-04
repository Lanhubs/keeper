import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:keeper/core/controllers/home_controller.dart';
import 'package:keeper/pages/home/screens/analytics/dashboard.dart';
import 'package:keeper/pages/home/screens/home/home.dart';
import 'package:keeper/pages/home/screens/invoices/invoices.dart';
import 'package:keeper/pages/home/screens/profile/profile.dart';
import "package:keeper/core/widgets/ui/app_icon.dart";

class MainHome extends GetView {
  final HomeController controller = Get.put(HomeController());
  MainHome({super.key});
  final List<Widget> _pages = [Home(), Invoices(), Analytics(), Profile()];

  final List<BottomNavigationBarItem> _bottomNavItems = [
    BottomNavigationBarItem(
      icon: AppIcon(HugeIcons.strokeRoundedHome04, size: 20),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: AppIcon(HugeIcons.strokeRoundedInvoice02, size: 20),
      label: "Invoices",
    ),
    BottomNavigationBarItem(
      icon: AppIcon(HugeIcons.strokeRoundedPieChart02, size: 20),
      label: "Analytics",
    ),
    BottomNavigationBarItem(
      icon: AppIcon(Icons.person_4_outlined, size: 20),
      label: "Profile",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(index: controller.currentIndex, children: _pages),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Obx(
          () => BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: Color(0xFF1E90FF),
            iconSize: 20,
            showUnselectedLabels: true,

            unselectedItemColor: Colors.grey,
            landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
            items: _bottomNavItems,

            currentIndex: controller.currentIndex,
            onTap: (index) {
              controller.changeIndex(index);
            },
          ),
        ),
      ),
    );
  }
}
