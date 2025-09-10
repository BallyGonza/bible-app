import 'package:flutter/material.dart';

class NumberButton extends StatelessWidget {
  const NumberButton({
    super.key,
    required this.number,
    this.color,
    required this.onTap,
  });

  final int number;
  final Color? color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = color ?? Theme.of(context).colorScheme.surface;

    // Calculate text color based on background for proper contrast
    final textColor = _calculateContrastColor(backgroundColor, context);

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(
        8,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          8,
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
          ),
        ),
      ),
    );
  }

  /// Calculate appropriate text color based on background color for optimal contrast
  Color _calculateContrastColor(Color backgroundColor, BuildContext context) {
    // If no custom color, use default Material 3 color
    if (color == null) {
      return Theme.of(context).colorScheme.onPrimaryContainer;
    }

    // Calculate luminance to determine if we need light or dark text
    final double luminance = backgroundColor.computeLuminance();

    // Use white text on dark backgrounds, black text on light backgrounds
    return luminance > 0.5 ? Colors.black87 : Colors.white;
  }
}
