// Suggested code may be subject to a license. Learn more: ~LicenseLog:4200905797.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1874637644.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:926541125.
import 'package:flutter/material.dart';
import 'package:myapp/src/screens/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  Future<void> _checkLoginState() async {
    String? token = await getToken();
    if (token != null) {
      Navigator.pushNamed(context, '/home');
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
