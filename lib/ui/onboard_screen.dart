import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weatherapp/ui/signin_screen.dart';
import 'package:weatherapp/ui/signup_screen.dart';

import '../utils/colors.dart';
import '../utils/widgets/common.dart';
import '../utils/widgets/gradient_text.dart';

class OnboardingScreen extends StatefulWidget {
  static const String route = "/onboard-screen";

  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: gradientBackground(),
        child: Column(
          children: [
            Expanded(
                child: Image.asset(
              "assets/images/map.png",
              width: double.infinity,
            )),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 0.0,
                      spreadRadius: -2,
                      offset: new Offset(2.0, 0.0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    header("Explore global map of wind, weather, and ocean conditions", fontSize: 22, isBold: true),
                    Container(
                      height: 5,
                    ),
                    subHeader(
                      "Planing your trip become more easier with ideate weather app. you can instantly see the whole word weather within few second",
                    ),
                    const Spacer(),
                    gradientButton("Get Started", onTap: () => Navigator.pushNamed(context, SignUpScreen.route)),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: /*RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.grey, fontSize: 17),
                        children: <TextSpan>[
                          TextSpan(text: 'Already have an account ? '),
                          TextSpan(
                              text: 'Login',
                              style: TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('Terms of Service"');
                                }),
                        ],
                      ),
                    )*/
                          Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account ? ",
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                          GradientText(
                            'Login',
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                            gradient: LinearGradient(colors: [
                              color1,
                              color2,
                            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                            onTap: () =>
                              Navigator.pushNamed(context, SignInScreen.route)
                            ,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
