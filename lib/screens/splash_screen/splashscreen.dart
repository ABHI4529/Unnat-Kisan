import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_screen/home.dart';
import '../login_screen/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future checkUser() async {
    final preferences = await SharedPreferences.getInstance();
    var loggedIn = preferences.getBool('isLoggedIn');
    if (loggedIn == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      checkUser();
      timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/unnat_kisan_logo.png",
              height: 300,
            ),
          ),
        ],
      ),
    );
  }
}
