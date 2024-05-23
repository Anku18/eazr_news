import 'package:eazr_news/screens/tabs/explore_tab.dart';
import 'package:eazr_news/screens/tabs/home_tab.dart';
import 'package:eazr_news/screens/tabs/bookmark_tab.dart';
import 'package:eazr_news/screens/tabs/setting_tab.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: _pageIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        children: const [
          HomeTab(),
          ExploreTab(),
          BookmarkTab(),
          SettingTab(),
        ],
      ),
      bottomNavigationBar: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: GNav(
            onTabChange: (value) {
              _pageController.jumpToPage(value);
            },
            selectedIndex: _pageIndex,
            iconSize: 26,
            backgroundColor: Colors.transparent,
            rippleColor: Theme.of(context).colorScheme.secondary,
            color: Theme.of(context).colorScheme.secondary,
            activeColor: Colors.white,
            tabBackgroundColor: Theme.of(context).primaryColor,
            gap: 8,
            padding: const EdgeInsets.all(10),
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.search, text: 'Search'),
              GButton(icon: Icons.bookmark_border_outlined, text: 'Saved'),
              GButton(icon: Icons.settings, text: 'Setting')
            ],
          ),
        ),
      ),
    );
  }
}
