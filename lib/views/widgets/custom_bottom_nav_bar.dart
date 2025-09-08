import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Configuration class for navigation items
class NavigationConfig {
  const NavigationConfig({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
}

/// Custom bottom navigation bar with Material 3 design
class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    required this.onTap,
    required this.currentIndex,
    required this.navigationItems,
    super.key,
  });

  final void Function(int) onTap;
  final int currentIndex;
  final List<NavigationConfig> navigationItems;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      backgroundColor: colorScheme.surface,
      elevation: 0,
      shadowColor: colorScheme.shadow.withOpacity(0.1),
      surfaceTintColor: colorScheme.surfaceTint,
      indicatorColor: colorScheme.secondaryContainer,
      destinations: navigationItems.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isSelected = index == currentIndex;

        return NavigationDestination(
          icon: FaIcon(
            item.icon,
            size: 20,
            color: isSelected
                ? colorScheme.onSecondaryContainer
                : colorScheme.onSurfaceVariant,
          ),
          label: item.label,
        );
      }).toList(),
    );
  }
}
