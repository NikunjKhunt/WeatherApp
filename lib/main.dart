import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/notifiers/login_notifier.dart';
import 'package:weatherapp/ui/splash_screen.dart';
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
      ],
      child: MaterialApp(
        scaffoldMessengerKey: _scaffoldKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: black,
        ),
        routes: routes,
        initialRoute: SplashScreen.route,
        // home: SplashScreen(),
      ),
    );
  }
}
