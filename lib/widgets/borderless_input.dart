import 'package:flutter/material.dart';

class BorderlessInput extends StatelessWidget {
  final TextInputType type;
  final void Function(dynamic) onchanged;
  String? placeholder;
  final double? width;

  BorderlessInput({
    super.key,
    this.width,
    required this.type,
    required this.onchanged,
    this.placeholder,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onchanged,
      keyboardType: type,
      decoration: InputDecoration(
        hintText: placeholder,
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.grey),
        constraints: BoxConstraints(maxWidth: width ?? 50),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 8,
        ),
      ),
    );
  }
}
