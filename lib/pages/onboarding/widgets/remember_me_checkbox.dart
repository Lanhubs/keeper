import 'package:flutter/material.dart';

class RememberMeCheckbox extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  final bool showForgetPassword;

  const RememberMeCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.showForgetPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => onChanged(!value),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: value ? const Color(0xFF1E90FF) : Colors.white,
                  border: Border.all(
                    color: value
                        ? const Color(0xFF1E90FF)
                        : Colors.grey.shade400,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: value
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "Remember me",
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
          ],
        ),
        if (showForgetPassword)
          Text(
            "Forget Password",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }
}
