import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:keeper/core/controllers/onboarding_controller.dart';
import 'package:keeper/pages/onboarding/widgets/auth_tab_selector.dart';
import 'package:keeper/pages/onboarding/widgets/auth_text_field.dart';
import 'package:keeper/pages/onboarding/widgets/remember_me_checkbox.dart';
import 'package:keeper/pages/onboarding/widgets/social_auth_section.dart';

class WelcomeScreen extends StatefulWidget {
  final OnboardingController controller;

  const WelcomeScreen({super.key, required this.controller});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isLogin = true;
  bool rememberMe = false;
  bool obscurePassword = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 10),
                constraints: BoxConstraints(minHeight: Get.height * 0.4,),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: Offset(1, 1),
                      blurRadius: 01,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    _buildBackButton(),
                    const SizedBox(height: 32),
                    _buildTitle(),
                    const SizedBox(height: 25),
                    AuthTabSelector(
                      isLogin: isLogin,
                      onTabChanged: (value) => setState(() => isLogin = value),
                    ),
                    const SizedBox(height: 24),
                    if (!isLogin) ...[
                      AuthTextField(
                        label: "Name***",
                        hint: "Your name",
                        controller: nameController,
                      ),
                      const SizedBox(height: 16),
                    ],
                    AuthTextField(
                      label: "Mail***",
                      hint: "blockaistudio@gmail.com",
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      suffixIcon: Icon(
                        Icons.mail_outline,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    AuthTextField(
                      label: "Password***",
                      hint: "••••••••••••",
                      controller: passwordController,
                      obscureText: obscurePassword,
                      suffixIcon: GestureDetector(
                        onTap: () =>
                            setState(() => obscurePassword = !obscurePassword),
                        child: Icon(
                          obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    RememberMeCheckbox(
                      value: rememberMe,
                      onChanged: (value) => setState(() => rememberMe = value),
                      showForgetPassword: isLogin,
                    ),
                    const SizedBox(height: 24),
                    _buildSubmitButton(),
                  ],
                ),
              ),
              Column(
                children: [
                  SocialAuthSection(
                    onGoogleTap: widget.controller.completeOnboarding,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => widget.controller.pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      "Welcome to\nKeeper",
      style: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        height: 1.2,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.controller.completeOnboarding,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1E90FF),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLogin ? "Get Started" : "Sign up",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward, size: 20),
          ],
        ),
      ),
    );
  }
}
