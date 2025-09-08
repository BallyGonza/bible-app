import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({
    required this.onTap,
    required this.currentIndex,
    super.key,
  });

  final void Function(int) onTap;
  final int currentIndex;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: widget.currentIndex,
      onDestinationSelected: (index) {
        setState(() {
          widget.onTap(index);
        });
      },
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      destinations: const [
        NavigationDestination(
          icon: FaIcon(
            FontAwesomeIcons.book,
            size: 20,
          ),
          label: 'Bible',
        ),
        NavigationDestination(
          icon: FaIcon(FontAwesomeIcons.bookOpen, size: 20),
          label: 'Notebook',
        ),
        NavigationDestination(
          icon: FaIcon(FontAwesomeIcons.magnifyingGlass, size: 20),
          label: 'Search',
        ),
      ],
    );
  }
}
