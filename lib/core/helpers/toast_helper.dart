import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import '../widgets/ui/app_icon.dart';

/// Utility class for showing toast notifications throughout the app
/// Ensures only one toast is shown at a time and provides consistent styling
class ToastHelper {
  // Track the current toast to dismiss it when showing a new one
  static ToastificationItem? _currentToast;

  /// Dismisses any currently showing toast
  static void dismissCurrent() {
    if (_currentToast != null) {
      toastification.dismiss(_currentToast!);
      _currentToast = null;
    }
  }

  /// Show a success toast message
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

  /// Show an error toast message
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

  /// Show an info toast message
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

  /// Show a warning toast message
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
