import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weatherapp/ui/day_screen.dart';
import 'package:weatherapp/ui/signin_screen.dart';
import 'package:weatherapp/utils/colors.dart';
import 'package:weatherapp/utils/shared_pref.dart';
import 'package:weatherapp/utils/widgets/gradient_text.dart';

class SplashScreen extends StatefulWidget {
  static const String route = "/";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), _checkUserStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              width: 150,
            ),
            const GradientText(
              'Forecasting',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              gradient: LinearGradient(colors: [
                color1,
                color2,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ],
        ),
      ),
    );
  }

  void _checkUserStatus() async {
    String token = await SharedPref.getAccessToken();
    if (!mounted) return;
    if (token.isNotEmpty) {
      Navigator.pushReplacementNamed(context, DayScreen.route);
    } else {
      Navigator.pushReplacementNamed(context, SignInScreen.route);
    }
  }
}
