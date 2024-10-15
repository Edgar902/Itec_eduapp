import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/providers/user_provider.dart';
import 'package:myapp/src/screens/Splash/splash_screen.dart';
import 'package:myapp/src/screens/home/home_screen.dart';
import 'package:myapp/src/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xFF19425A),
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider())
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            initialRoute: '',
            routes: {
              '/': (context) => const SplashScreen(),
              '/login': (context) => const LoginScreen(),
              '/home': (context) => const HomePage(),
            }));
  }
}
