import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import "package:keeper/core/widgets/ui/app_icon.dart";
import 'package:keeper/widgets/fillter_bottom_sheet.dart';

class SearchInput extends StatelessWidget {
  final void Function(String)? onChanged;
  final void Function()? onFilterTap;
  final void Function(String? status, DateTimeRange? dateRange)? onFilterApply;
  final String? hintText;
  final bool showFilter;

  const SearchInput({
    super.key,
    this.onChanged,
    this.onFilterTap,
    this.onFilterApply,
    this.hintText,
    this.showFilter = true,
  });

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => FilterBottomSheet(onApply: onFilterApply),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText ?? "Search",
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
              prefixIcon: const Padding(
                padding: EdgeInsets.all(12.0),
                child: AppIcon(Icons.search, color: Colors.grey, size: 20),
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 44,
                minHeight: 44,
              ),
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
          ),
        ),
        if (showFilter) ...[
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onFilterTap ?? () => Get.bottomSheet(FilterBottomSheet()),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF1E90FF),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                child: AppIcon(
                  HugeIcons.strokeRoundedFilterVertical,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

