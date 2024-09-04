// Suggested code may be subject to a license. Learn more: ~LicenseLog:3786180388.
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:myapp/src/screens/home/Homepage_screen.dart';
import 'package:myapp/src/screens/tasks/tasks_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  late PageController _pageController;

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

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
          child: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: const [HomepageScreen(), TasksScreen()],
      )),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          child: GNav(
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              gap: 8,
              onTabChange: (index) {
                _pageController.jumpToPage(index);
              },
              padding: const EdgeInsets.all(10),
              tabs: const [
                GButton(icon: Icons.home, text: "Home"),
                GButton(icon: Icons.favorite_border, text: "Likes"),
                GButton(icon: Icons.search, text: "Search"),
                GButton(icon: Icons.settings, text: "Settings"),
              ]),
        ),
      ),
    );
  }
}
