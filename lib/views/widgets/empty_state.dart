import 'package:flutter/material.dart';

/// A reusable widget for displaying empty states with consistent design
class EmptyState extends StatelessWidget {
  const EmptyState({
    required this.icon,
    required this.title,
    this.subtitle,
    this.iconSize = 64,
    this.titleStyle,
    this.subtitleStyle,
    super.key,
  }) : isSmall = false;

  const EmptyState.small({
    required this.icon,
    required this.title,
    this.subtitle,
    this.iconSize = 48,
    this.titleStyle,
    this.subtitleStyle,
    super.key,
  }) : isSmall = true;

  /// Whether this is the small variant
  final bool isSmall;

  /// The icon to display at the top
  final IconData icon;

  /// The main title text
  final String title;

  /// The subtitle/description text
  final String? subtitle;

  /// Size of the icon (default: 64)
  final double iconSize;

  /// Custom style for the title (optional)
  final TextStyle? titleStyle;

  /// Custom style for the subtitle (optional)
  final TextStyle? subtitleStyle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: Colors.grey,
          ),
          SizedBox(height: isSmall ? 10 : 16),
          Text(
            title,
            style: titleStyle ??
                TextStyle(
                  fontSize: isSmall ? 14 : 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
          ),
          if (subtitle != null) ...[
            SizedBox(height: isSmall ? 1 : 4),
            Text(
              subtitle!,
              style: subtitleStyle ??
                  TextStyle(
                    fontSize: isSmall ? 10 : 14,
                    color: Colors.grey,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
