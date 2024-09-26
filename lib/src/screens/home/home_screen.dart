// Suggested code may be subject to a license. Learn more: ~LicenseLog:3786180388.
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:myapp/src/screens/calendar/events.dart';
import 'package:myapp/src/screens/home/Homepage_screen.dart';
import 'package:myapp/src/screens/user/user_screen.dart';

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
        children: [HomepageScreen(), Events(), user_screen()],
      )),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.35),
                blurRadius: 15,
                spreadRadius: 0,
                offset: Offset(
                  0,
                  5,
                ),
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          child: GNav(
              backgroundColor: Colors.white,
              color: Color(0xFF19425A),
              activeColor: Color(0xFF19425A),
              gap: 8,
              onTabChange: (index) {
                _pageController.jumpToPage(index);
              },
              padding: const EdgeInsets.all(10),
              tabs: const [
                GButton(icon: Icons.home, text: "Inicio"),
                GButton(icon: Icons.calendar_month, text: "Calendario"),
                GButton(icon: Icons.person, text: "Perfil"),
                GButton(icon: Icons.settings, text: "Configuracion"),
              ]),
        ),
      ),
    );
  }
}
