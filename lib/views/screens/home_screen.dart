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
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          BibleScreen(
            user: widget.user,
          ),
          const NoteBookScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
        selectedIndex: _selectedIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(
              FontAwesomeIcons.book,
            ),
            label: 'Bible',
          ),
          NavigationDestination(
            icon: Icon(
              FontAwesomeIcons.noteSticky,
            ),
            label: 'Notebook',
          ),
        ],
      ),
    );
  }
}
