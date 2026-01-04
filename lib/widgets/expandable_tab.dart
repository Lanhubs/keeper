import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:keeper/constants/utils.dart';
import 'package:keeper/pages/home/screens/invoices/widgets/create_invoice_modal.dart';
import "package:keeper/core/widgets/ui/app_icon.dart";

class ExpandableFab extends StatefulWidget {
  @override
  _ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 250),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        if (_isExpanded) ...[
          buildOption(HugeIcons.strokeRoundedInvoice03, 'Add Invoice', 1, () {
            Get.toNamed(AppRoutes.createInvoice);
            // Get.to(CreateInvoiceModal(), transition: Transition.downToUp);
            _toggle();
          }),
          buildOption(Icons.person_add_outlined, 'Add Client', 2, () {
            Get.toNamed(AppRoutes.addClient);
            _toggle();
          }),
          // buildOption(
          //   HugeIcons.strokeRoundedPayment01,
          //   'Add Payment',
          //   3,
          //   () {},
          // ),
          buildOption(
            HugeIcons.strokeRoundedMoneyRemove02,
            'Add Expense',
            3,
            () {},
          ),
        ],
        FloatingActionButton(
          backgroundColor: Color(0xFF1E90FF),
          onPressed: _toggle,
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _animation,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget buildOption(
    dynamic icon,
    String label,
    int index,
    VoidCallback handler,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 70.0 * index),
      child: FloatingActionButton(
        backgroundColor: Color(0xFF1E90FF),
        // mini: true,
        onPressed: handler,
        heroTag: label,
        tooltip: label,
        child: AppIcon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
