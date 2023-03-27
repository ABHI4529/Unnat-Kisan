import 'package:flutter/material.dart';
import 'package:unnatkisan/screens/home_screen/home.dart';
import 'package:unnatkisan/screens/login_screen/login.dart';
import 'package:unnatkisan/screens/signup_screen/signup.dart';
import 'package:unnatkisan/screens/splash_screen/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainTheme());
}

class MainTheme extends StatefulWidget {
  const MainTheme({super.key});

  @override
  State<MainTheme> createState() => _MainThemeState();
}

class _MainThemeState extends State<MainTheme> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme(
              onSurface: Colors.black,
              surface: Colors.white,
              onBackground: Colors.black,
              background: Colors.white,
              error: Colors.red.shade300,
              onError: Colors.red.shade300,
              onSecondary: Colors.white,
              secondary: Colors.black,
              onPrimary: Colors.white,
              brightness: Brightness.light,
              primary: const Color(0xff4C7845)),
          navigationBarTheme: NavigationBarThemeData(
              indicatorColor: const Color(0xff4C7845).withAlpha(100),
              backgroundColor: const Color(0xff4C7845).withAlpha(50))),
      home: SplashScreen(),
    );
  }
}
