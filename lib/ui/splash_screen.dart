import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weatherapp/ui/onboard_screen.dart';
import 'package:weatherapp/utils/colors.dart';
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
    Timer(const Duration(seconds: 3),
            ()=>/*Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                const OnboardingScreen()
            )
        )*/
        Navigator.pushReplacementNamed(context, OnboardingScreen.route)
    );
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
            Image.asset("assets/images/logo.png"),
            const GradientText(
              'Forecasting',
              style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),
              gradient: LinearGradient(colors: [
                color1,
                color2,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
            ),
          ],
        ),
      ),
    );
  }
}
