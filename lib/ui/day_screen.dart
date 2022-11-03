import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weatherapp/ui/weather_screen.dart';
import 'package:weatherapp/utils/constants.dart';
import 'package:weatherapp/utils/extentions.dart';
import 'package:weatherapp/utils/widgets/common.dart';

import '../utils/colors.dart';
import '../utils/widgets/shadow_text.dart';

class DayScreen extends StatelessWidget {
  static const String route = "/day-screen";

  final WeatherType weather = WeatherType.cloudy;

  const DayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _body(context, size),
    );
  }

  _body(BuildContext context, Size size) {
    return Container(
      margin: EdgeInsets.only(top: 32),
      decoration: gradientBackground(),
      padding: EdgeInsets.all(Cons.space),
      child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/images/ic_location.webp",
                    height: 25,
                  ),
                  hSpace(width: 8),
                  header("text", color: Colors.white, fontSize: 25),
                  hSpace(width: 8),
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.white,
                  ),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () => showLogoutDialog(context),
                child: Container(
                  height: 35,
                  width: 35,
                  padding: EdgeInsets.all(5),
                  child: Image.asset(
                    "assets/images/ic_logout.webp",
                  ),
                ),
              ),
            ],
          ),
          Flexible(
            child: Image.asset(
              weather.icon,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
            decoration: whiteBackgroundWithBorder(),
            child: Column(
              children: [
                header("Today, 12 September", color: Colors.white, isBold: false),
                ShadowText(
                  '29'.toTemp(),
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.white, fontSize: 70),
                ),
                header(weather.displayName, color: Colors.white),
                vSpace(),
                _weatherDetail("Time", "06:00 AM"),
                _weatherDetail("Time", "06:00 AM"),
                _weatherDetail("Time", "06:00 AM"),
                _weatherDetail("Time", "06:00 AM"),
                _weatherDetail("Time", "06:00 AM"),
                _weatherDetail("Time", "06:00 AM"),
                _weatherDetail("Time", "06:00 AM"),
              ],
            ),
          ),
          vSpace(),
          button(
            "Forecast Report ",
            icon: const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 20,
              color: buttonTextColor,
            ),
            horizontalMargin: 50,
            onTap: () => Navigator.of(context).pushNamed(WeatherScreen.route),
          )
        ],
      ),
    );
  }

  _weatherDetail(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Image.asset(
            "assets/images/ic_wind.webp",
            height: 25,
          ),
          hSpace(width: 8),
          header(title, color: Colors.white, isBold: false),
          const Spacer(),
          header(value, color: Colors.white, isBold: false),
        ],
      ),
    );
  }

  showLogoutDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(35.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              padding: EdgeInsets.all(Cons.space),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipOval(
                    child: Container(
                      height: 120,
                      width: 120,
                      padding: EdgeInsets.all(20),
                      color: lightRedColor,
                      child: Image.asset(
                        "assets/images/ic_logout.webp",
                      ),
                    ),
                  ),
                  vSpace(height: 24),
                  header("Logout"),
                  vSpace(height: 8),
                  subHeader("Are you sure you want to logout from app", isCenter: true, color: subTextColor),
                  vSpace(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          color: redColor,
                            border: Border.all(
                              color: redColor,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        child: Center(
                          child: Text(
                            "Logout",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      hSpace(),
                      Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          color: negativeButtonColor,
                            border: Border.all(
                              color: negativeButtonColor,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        child: Center(
                          child: Text(
                            "Cancel",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      // button("Logout", onTap: (){},bgColor: redColor,textColor: Colors.white),
                      // button("Cancel", onTap: (){},bgColor: negativeButtonColor),
                    ],
                  ),
                  vSpace(height: 8),
                ],
              ),
            ),
          );
        });
  }

  showCityDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(35.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              padding: EdgeInsets.all(Cons.space),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipOval(
                    child: Container(
                      height: 120,
                      width: 120,
                      padding: EdgeInsets.all(20),
                      color: lightRedColor,
                      child: Image.asset(
                        "assets/images/ic_logout.webp",
                      ),
                    ),
                  ),
                  vSpace(height: 24),
                  header("Logout"),
                  vSpace(height: 8),
                  subHeader("Are you sure you want to logout from app", isCenter: true, color: subTextColor),
                  vSpace(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          color: redColor,
                            border: Border.all(
                              color: redColor,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        child: Center(
                          child: Text(
                            "Logout",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      hSpace(),
                      Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          color: negativeButtonColor,
                            border: Border.all(
                              color: negativeButtonColor,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        child: Center(
                          child: Text(
                            "Cancel",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      // button("Logout", onTap: (){},bgColor: redColor,textColor: Colors.white),
                      // button("Cancel", onTap: (){},bgColor: negativeButtonColor),
                    ],
                  ),
                  vSpace(height: 8),
                ],
              ),
            ),
          );
        });
  }
}
