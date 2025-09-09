import 'package:flutter/material.dart';

/// A premium Material 3 compliant SliverAppBar widget with advanced theming and interactions
class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    required this.title,
    this.subtitle,
    this.actions,
    this.arrowBack = false,
    this.expandedHeight = 140,
    this.flexibleSpaceWidget,
    this.backgroundColor,
    this.showScrim = true,
    super.key,
  });

  final String title;
  final String? subtitle;
  final bool arrowBack;
  final double expandedHeight;
  final List<Widget>? actions;
  final Widget? flexibleSpaceWidget;
  final Color? backgroundColor;
  final bool showScrim;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final effectiveBackgroundColor =
        backgroundColor ?? colorScheme.surfaceContainer;

    return SliverAppBar.medium(
      backgroundColor: effectiveBackgroundColor,
      surfaceTintColor: colorScheme.surfaceTint,
      elevation: 0,
      shadowColor: colorScheme.shadow.withOpacity(0.1),
      actions: actions,
      automaticallyImplyLeading: arrowBack,
      expandedHeight: expandedHeight,
      pinned: true,
      centerTitle: false,
      title: Text(
        title,
        style: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            color: effectiveBackgroundColor,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                effectiveBackgroundColor.withOpacity(0.9),
                effectiveBackgroundColor,
              ],
            ),
          ),
          child: Stack(
            children: [
              // Main content
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Title with Material 3 emphasis
                    Text(
                      title,
                      style: textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurface,
                        height: 1.2,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        subtitle!,
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Optional scrim effect
              if (showScrim)
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          colorScheme.surfaceTint.withOpacity(0.05),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
