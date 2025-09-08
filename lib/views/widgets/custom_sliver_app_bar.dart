import 'package:flutter/material.dart';

/// A Material 3 compliant SliverAppBar widget with proper theming and typography
class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    required this.title,
    this.subtitle,
    this.actions,
    this.arrowBack = false,
    this.expandedHeight = 120,
    this.flexibleSpaceWidget,
    super.key,
  });

  final String title;
  final String? subtitle;
  final bool arrowBack;
  final double expandedHeight;
  final List<Widget>? actions;
  final Widget? flexibleSpaceWidget;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SliverAppBar.medium(
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surface,
      elevation: 0,
      actions: actions,
      automaticallyImplyLeading: arrowBack,
      expandedHeight: expandedHeight,
      centerTitle: false,
      title: Text(
        title,
        style: textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
      ),
      flexibleSpace: flexibleSpaceWidget ??
          FlexibleSpaceBar(
            background: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  if (subtitle != null) ...[
                    Text(
                      subtitle!,
                      style: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
    );
  }
}
