import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weatherapp/utils/constants.dart';
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
              Spacer(),
              Image.asset(
                "assets/images/ic_logout.webp",
                height: 22,
              ),
              hSpace(),
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
            decoration: BoxDecoration(
                color: Colors.white.withAlpha(75), borderRadius: BorderRadius.all(Radius.circular(20)), border: Border.all(color: whiteColor70, width: 2)
                /*boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 0.0,
                  spreadRadius: -2,
                  offset: new Offset(2.0, 0.0),
                ),
              ]*/
                ),
            child: Column(
              children: [
                header("Today, 12 September", color: Colors.white, isBold: false),
                ShadowText(
                  '29\u00B0',
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.white, fontSize: 70),
                ),
                header(weather.displayName,color: Colors.white),
                vSpace(),
                _weatherDetail("Time","06:00 AM"),
                _weatherDetail("Time","06:00 AM"),
                _weatherDetail("Time","06:00 AM"),
                _weatherDetail("Time","06:00 AM"),
                _weatherDetail("Time","06:00 AM"),
                _weatherDetail("Time","06:00 AM"),
                _weatherDetail("Time","06:00 AM"),
              ],
            ),
          ),
button("Forecast Report > ", onTap: (){})
        ],
      ),
    );
  }

  _weatherDetail(String title, String value) {
    return Container(
      padding: EdgeInsets.all(4),
      child: Row(children: [
        Image.asset("assets/images/ic_wind.webp",height: 25,),
        hSpace(width: 8),
        header(title, color: Colors.white, isBold: false),
        Spacer(),
        header(value, color: Colors.white, isBold: false),
      ],),
    );
  }
}
