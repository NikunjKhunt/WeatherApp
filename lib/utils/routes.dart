
import 'package:weatherapp/ui/onboard_screen.dart';
import 'package:weatherapp/ui/signin_screen.dart';
import 'package:weatherapp/ui/signup_screen.dart';
import 'package:weatherapp/ui/splash_screen.dart';

var routes = {
  SplashScreen.route: (context) => const SplashScreen(),
  OnboardingScreen.route: (context) => const OnboardingScreen(),
  SignUpScreen.route: (context) => const SignUpScreen(),
  SignInScreen.route: (context) => const SignInScreen(),
};