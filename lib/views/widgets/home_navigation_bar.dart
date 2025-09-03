import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.navigationItems,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<NavigationConfig> navigationItems;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      destinations: navigationItems
          .map((config) => NavigationDestination(
                icon: FaIcon(config.icon),
                label: config.label,
              ))
          .toList(),
      onDestinationSelected: onDestinationSelected,
    );
  }
}

class NavigationConfig {
  const NavigationConfig({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
}
