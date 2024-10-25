// Suggested code may be subject to a license. Learn more: ~LicenseLog:3786180388.
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:myapp/providers/user_provider.dart';
import 'package:myapp/src/screens/calendar/events.dart';
import 'package:myapp/src/screens/config/config_screen.dart';
import 'package:myapp/src/screens/home/Homepage_screen.dart';

import 'package:myapp/src/screens/user/user_screen.dart';
import 'package:provider/provider.dart';

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
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    userProvider.fetchUserData();
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
    final users = context.watch<UserProvider>().userName ?? "";
    print(users);
    return Scaffold(
      body: SizedBox.expand(
          child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: const [
          HomePageScreen(),
          Events(),
          UserScreen(),
          ConfigScreen()
        ],
      )),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
              color: const Color(0xFF19425A),
              activeColor: const Color(0xFF19425A),
              gap: 8,
              onTabChange: (index) {
                _pageController.jumpToPage(index);
              },
              padding: const EdgeInsets.all(10),
              tabs: const [
                GButton(icon: Icons.home, text: "inicio"),
                GButton(icon: Icons.calendar_month, text: "Calendario"),
                GButton(icon: Icons.person, text: "Perfil"),
                GButton(icon: Icons.settings, text: "Configuracion"),
              ]),
        ),
      ),
    );
  }
}
