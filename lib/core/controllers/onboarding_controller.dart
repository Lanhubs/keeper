import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keeper/constants/utils.dart';

class OnboardingController extends GetxController {
  final box = Hive.box("Settings");
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final List<OnboardingPage> pages = [
    OnboardingPage(
      title: "Create, track, and manage\n invoices—within seconds",
      description: "",
      icon: Icons.star,
    ),
    OnboardingPage(
      title: "Create, track, and manage\ninvoices—within seconds",
      description: "",
      icon: Icons.view_week,
    ),
    OnboardingPage(
      title: "Welcome to Keeper",
      description: "Get started with managing your invoices",
      icon: Icons.check_circle,
    ),
  ];

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void nextPage() {
    if (currentPage.value < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      completeOnboarding();
    }
  }

  void skipOnboarding() {
    completeOnboarding();
  }

  Future<void> completeOnboarding() async {
    await box.put('hasSeenOnboarding', true);
    Get.offAllNamed(AppRoutes.home);
  }

  void onPageChanged(int page) {
    currentPage.value = page;
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final IconData icon;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.icon,
  });
}
