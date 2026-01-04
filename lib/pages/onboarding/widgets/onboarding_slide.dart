import 'package:flutter/material.dart';

class OnboardingSlide extends StatelessWidget {
  final IconData icon;
  final bool isDark;
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;

  const OnboardingSlide({
    super.key,
    required this.icon,
    required this.isDark,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDark ? Colors.black : Colors.grey.shade200,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 40),
              Expanded(child: Center(child: _buildIcon())),
              Column(
                children: [
                  _buildPageIndicators(),
                  const SizedBox(height: 40),
                  Text(
                    "Create, track, and manage\ninvoices—within seconds",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildNextButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (currentPage == 0) {
      return Image.asset(
        'assets/book-keeping.png',
        width: 200,
        height: 200,
        fit: BoxFit.contain,
      );
    } else {
      return ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        child: Image.asset(
          'assets/keeping.png',
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
      );
    }
  }

  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: index == currentPage ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: index == currentPage
                ? const Color(0xFF1E90FF)
                : (isDark ? Colors.grey.shade700 : Colors.grey.shade400),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: onNext,
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF1E90FF), width: 2),
          ),
          child: const Icon(
            Icons.arrow_forward,
            color: Color(0xFF1E90FF),
            size: 28,
          ),
        ),
      ),
    );
  }
}
