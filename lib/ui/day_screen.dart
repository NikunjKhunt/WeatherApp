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
          InkWell(
            onTap: () => _showDialog(context),
            child: Row(
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

  Future<void> _showDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
}
