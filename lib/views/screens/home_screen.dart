import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    required this.user,
    super.key,
  });

  final UserModel user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController;
  int _selectedIndex = 0;

  // Constants for better maintainability
  static const Duration _animationDuration = Duration(milliseconds: 300);
  static const Curve _animationCurve = Curves.easeInOut;

  // Navigation configuration
  static const List<NavigationConfig> _navigationItems = [
    NavigationConfig(
      icon: FontAwesomeIcons.book,
      label: 'Biblia',
    ),
    NavigationConfig(
      icon: FontAwesomeIcons.noteSticky,
      label: 'Notas',
    ),
    NavigationConfig(
      icon: FontAwesomeIcons.magnifyingGlass,
      label: 'Buscar',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _onDestinationSelected(int index) {
    if (_selectedIndex == index) return;

    _pageController.animateToPage(
      index,
      duration: _animationDuration,
      curve: _animationCurve,
    );
  }

  List<Widget> get _pages => [
        BibleScreen(user: widget.user),
        const NoteBookScreen(),
        SearchScreen(user: widget.user),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _pages,
      ),
      bottomNavigationBar: HomeNavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        navigationItems: _navigationItems,
      ),
    );
  }
}
