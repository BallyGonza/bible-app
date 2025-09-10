import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Configuration for navigation items
class NavigationConfig {
  const NavigationConfig({
    required this.icon,
    required this.label,
    required this.routeName,
  });
  final IconData icon;
  final String label;
  final String routeName;
}

/// Home screen that manages bottom navigation and page views
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    required this.user,
    super.key,
  });

  final UserModel user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final PageController _pageController;
  late final List<Widget> _pages;
  int _selectedIndex = 0;

  // Constants
  static const Duration _animationDuration = Duration(milliseconds: 300);
  static const Curve _animationCurve = Curves.easeInOut;

  // Navigation configuration
  static const List<NavigationConfig> _navigationItems = [
    NavigationConfig(
      icon: FontAwesomeIcons.book,
      label: 'Biblia',
      routeName: '/bible',
    ),
    NavigationConfig(
      icon: FontAwesomeIcons.noteSticky,
      label: 'Notas',
      routeName: '/notes',
    ),
    NavigationConfig(
      icon: FontAwesomeIcons.magnifyingGlass,
      label: 'Buscar',
      routeName: '/search',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _initializePages();
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.user != oldWidget.user) {
      _initializePages();
    }
  }

  void _initializePages() {
    _pages = <Widget>[
      BibleScreen(user: widget.user),
      const NoteBookScreen(),
      SearchScreen(user: widget.user),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);
  }

  void _onDestinationSelected(int index) {
    if (_selectedIndex == index) return;
    _pageController.animateToPage(
      index,
      duration: _animationDuration,
      curve: _animationCurve,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        itemCount: _pages.length,
        itemBuilder: (context, index) => _pages[index],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return NavigationBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: _onDestinationSelected,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      destinations: _navigationItems
          .map(
            (item) => NavigationDestination(
              icon: Icon(item.icon),
              label: item.label,
              selectedIcon:
                  Icon(item.icon, color: Theme.of(context).colorScheme.primary),
            ),
          )
          .toList(),
    );
  }
}
