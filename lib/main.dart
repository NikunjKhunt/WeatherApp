import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/notifiers/home_notifier.dart';
import 'package:weatherapp/notifiers/login_notifier.dart';
import 'package:weatherapp/notifiers/weather_notifier.dart';
import 'package:weatherapp/ui/day_screen.dart';
import 'package:weatherapp/ui/signin_screen.dart';
import 'package:weatherapp/ui/signup_screen.dart';
import 'package:weatherapp/ui/splash_screen.dart';
import 'package:weatherapp/ui/weather_screen.dart';
import 'package:weatherapp/utils/colors.dart';
import 'package:weatherapp/utils/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginNotifier()),
        ChangeNotifierProvider(create: (context) => HomeNotifier()),
        ChangeNotifierProvider(create: (context) => WeatherNotifier()),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: _scaffoldKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: black,
        ),
        onGenerateRoute: _handleRoutes,
        // routes: routes,
        initialRoute: SplashScreen.route,
        // home: SplashScreen(),
      ),
    );
  }

  Route? _handleRoutes(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case SplashScreen.route:
        return MaterialPageRoute(builder: (context) => SplashScreen(),);
      case SignInScreen.route:
        return MaterialPageRoute(builder: (context) => SignInScreen(),);
      case SignUpScreen.route:
        return MaterialPageRoute(builder: (context) => SignUpScreen(),);
      case DayScreen.route:
        return MaterialPageRoute(builder: (context) => DayScreen(),);
      case WeatherScreen.route:
        return MaterialPageRoute(builder: (context) => WeatherScreen(cityId: args as String,),);
    }
  }
}
