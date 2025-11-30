import 'package:flutter/material.dart';

class UIHelper {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  static void closeDialog(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  // New: Safe close dialog that checks if context is mounted
  static void safeCloseDialog(BuildContext context) {
    try {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint('Error closing dialog: $e');
    }
  }

  // New: Show loading with SnackBar instead of dialog (safer for async operations)
  static void showLoadingSnackBar(
    BuildContext context, {
    String message = 'Loading...',
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            Text(message),
          ],
        ),
        duration: const Duration(minutes: 5), // Long duration
      ),
    );
  }

  // New: Hide loading snackbar
  static void hideLoadingSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static Future<bool?> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String message,
    String cancelText = "Cancel",
    String confirmText = "OK",
  }) {
    return showDialog<bool>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: Text(cancelText),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: Text(confirmText),
              ),
            ],
          ),
    );
  }

  static void showInfoSnackBar(
    BuildContext context,
    String message, {
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor ?? Colors.blue,
        duration: duration,
      ),
    );
  }

  // New: Show custom snackbar with action
  static void showSnackBarWithAction(
    BuildContext context, {
    required String message,
    required String actionLabel,
    required VoidCallback onActionPressed,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        action: SnackBarAction(
          label: actionLabel,
          textColor: Colors.white,
          onPressed: onActionPressed,
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
