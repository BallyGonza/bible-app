import 'package:flutter/material.dart';

/// A Material 3 compliant custom SnackBar widget with proper theming and accessibility
class CustomSnackBar {
  /// Shows a success SnackBar
  static void showSuccess(BuildContext context, {required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar(context, text, _SnackBarType.success));
  }

  /// Shows an error SnackBar
  static void showError(BuildContext context, {required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar(context, text, _SnackBarType.error));
  }

  /// Shows a custom SnackBar with specified color
  static void showCustom(BuildContext context, {required String text, required Color color}) {
    ScaffoldMessenger.of(context).showSnackBar(_buildCustomSnackBar(context, text, color));
  }

  /// Builds a SnackBar with the specified type
  static SnackBar _buildSnackBar(BuildContext context, String text, _SnackBarType type) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Determine colors based on type
    final (backgroundColor, iconColor, textColor, icon) = _getSnackBarConfig(colorScheme, type);

    return SnackBar(
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: textTheme.bodyMedium?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a custom SnackBar with specified color
  static SnackBar _buildCustomSnackBar(BuildContext context, String text, Color color) {
    final textTheme = Theme.of(context).textTheme;

    final backgroundColor = color;
    final luminance = backgroundColor.computeLuminance();
    final textAndIconColor = luminance > 0.5 ? Colors.black87 : Colors.white;

    return SnackBar(
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: textAndIconColor,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: textTheme.bodyMedium?.copyWith(
                    color: textAndIconColor,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  /// Get configuration based on snackbar type
  static (Color backgroundColor, Color iconColor, Color textColor, IconData icon) _getSnackBarConfig(ColorScheme colorScheme, _SnackBarType type) {
    return switch (type) {
      _SnackBarType.success => (
          colorScheme.primaryContainer,
          colorScheme.onPrimaryContainer,
          colorScheme.onPrimaryContainer,
          Icons.check_circle_outline,
        ),
      _SnackBarType.error => (
          colorScheme.errorContainer,
          colorScheme.onErrorContainer,
          colorScheme.onErrorContainer,
          Icons.error_outline,
        ),
    };
  }
}

/// Internal enum for snackbar types
enum _SnackBarType {
  success,
  error,
}
