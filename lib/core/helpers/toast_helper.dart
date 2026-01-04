import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import '../widgets/ui/app_icon.dart';

class ToastHelper {
  static ToastificationItem? _currentToast;

  static void dismissCurrent() {
    if (_currentToast != null) {
      toastification.dismiss(_currentToast!);
      _currentToast = null;
    }
  }

  static void showSuccess(String message, {Duration? duration}) {
    dismissCurrent();
    _currentToast = toastification.show(
      autoCloseDuration: duration ?? const Duration(milliseconds: 2000),
      type: ToastificationType.success,
      backgroundColor: const Color(0xFFA8E65C),
      title: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontFamily: GoogleFonts.manrope().fontFamily,
        ),
      ),
      icon: AppIcon(
        HugeIcons.strokeRoundedCheckmarkBadge01,
        color: Colors.white,
      ),
    );
  }

  static void showError(String message, {Duration? duration}) {
    dismissCurrent();
    _currentToast = toastification.show(
      autoCloseDuration: duration ?? const Duration(milliseconds: 2000),
      type: ToastificationType.error,
      backgroundColor: Colors.red,
      title: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontFamily: GoogleFonts.manrope().fontFamily,
        ),
      ),
      icon: AppIcon(HugeIcons.strokeRoundedRssError, color: Colors.white),
    );
  }

  static void showInfo(String message, {Duration? duration}) {
    dismissCurrent();
    _currentToast = toastification.show(
      autoCloseDuration: duration ?? const Duration(milliseconds: 2000),
      type: ToastificationType.info,
      backgroundColor: const Color(0xFFA8E65C),
      title: Text(
        message,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
          fontFamily: GoogleFonts.manrope().fontFamily,
        ),
      ),
      icon: AppIcon(
        HugeIcons.strokeRoundedInformationCircle,
        color: Colors.black,
      ),
    );
  }

  static void showWarning(String message, {Duration? duration}) {
    dismissCurrent();
    _currentToast = toastification.show(
      autoCloseDuration: duration ?? const Duration(milliseconds: 2000),
      type: ToastificationType.warning,
      backgroundColor: Colors.orange,
      title: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontFamily: GoogleFonts.manrope().fontFamily,
        ),
      ),
      icon: AppIcon(HugeIcons.strokeRoundedAlert02, color: Colors.white),
    );
  }
}
