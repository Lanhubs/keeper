import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keeper/core/controllers/onboarding_controller.dart';
import 'package:keeper/pages/onboarding/widgets/onboarding_slide.dart';
import 'package:keeper/pages/onboarding/widgets/welcome_screen.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: PageView.builder(
        controller: controller.pageController,
        onPageChanged: controller.onPageChanged,
        itemCount: controller.pages.length,
        itemBuilder: (context, index) {
          if (index < 2) {
            return OnboardingSlide(
              icon: controller.pages[index].icon,
              isDark: index == 1,
              currentPage: index,
              totalPages: 2,
              onNext: controller.nextPage,
            );
          } else {
            return WelcomeScreen(controller: controller);
          }
        },
      ),
    );
  }
}
