import 'package:flutter/material.dart';
import 'package:weatherapp/ui/splash_screen.dart';
import 'package:weatherapp/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      initialRoute: SplashScreen.route,
      // home: SplashScreen(),
    );
  }
}
