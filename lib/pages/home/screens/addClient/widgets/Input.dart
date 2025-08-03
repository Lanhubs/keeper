import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Input extends StatelessWidget {
  final String label;
  final String? placeholder;

  final void Function(String)? onChanged;
  final TextInputType type;
  const Input({
    super.key,
    required this.label,
    required this.onChanged,
    this.type = TextInputType.text,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        TextFormField(
          onChanged: onChanged,
          keyboardType: type,
          decoration: InputDecoration(
            hintText: placeholder,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(color: Colors.grey.shade600, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}
