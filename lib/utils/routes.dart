
import 'package:weatherapp/ui/onboard_screen.dart';
import 'package:weatherapp/ui/signin_screen.dart';
import 'package:weatherapp/ui/signup_screen.dart';
import 'package:weatherapp/ui/splash_screen.dart';

import '../ui/day_screen.dart';
import '../ui/weather_screen.dart';

var routes = {
  SplashScreen.route: (context) => const SplashScreen(),
  OnboardingScreen.route: (context) => const OnboardingScreen(),
  SignUpScreen.route: (context) => const SignUpScreen(),
  SignInScreen.route: (context) => const SignInScreen(),
  DayScreen.route: (context) => const DayScreen(),
  WeatherScreen.route: (context) => const WeatherScreen(),
};