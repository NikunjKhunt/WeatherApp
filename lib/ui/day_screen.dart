import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/models/City.dart';
import 'package:weatherapp/notifiers/home_notifier.dart';
import 'package:weatherapp/ui/signin_screen.dart';
import 'package:weatherapp/ui/weather_screen.dart';
import 'package:weatherapp/utils/constants.dart';
import 'package:weatherapp/utils/extentions.dart';
import 'package:weatherapp/utils/shared_pref.dart';
import 'package:weatherapp/utils/widgets/common.dart';

import '../utils/colors.dart';
import '../utils/widgets/shadow_text.dart';

class DayScreen extends StatefulWidget {
  static const String route = "/day-screen";

  const DayScreen({Key? key}) : super(key: key);

  @override
  State<DayScreen> createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {
  late HomeNotifier homeNotifier;
  final WeatherType weather = WeatherType.cloudy;
  String? _selectedCity;

  @override
  void initState() {
    super.initState();
    homeNotifier = Provider.of<HomeNotifier>(context, listen: false);
    Future.delayed(const Duration(milliseconds: 0)).then((value) async {
      _selectedCity = await SharedPref.getDefaultCity();
      homeNotifier.fetchData(_selectedCity!);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: ValueListenableBuilder<ApiStatus>(
      valueListenable: homeNotifier.progressBar,
      builder: (context, value, child) {
        return Stack(
          children: [
            _body(context, size),
            if (value == ApiStatus.processing)
              Container(
                height: double.infinity,
                width: double.infinity,
                color: whiteColor70,
                child: Center(
                  child: CircularProgressIndicator(
                    color: color2,
                  ),
                ),
              )
          ],
        );
      },
    ));
  }

  _body(BuildContext context, Size size) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: gradientBackground(),
      padding: EdgeInsets.all(Cons.space),
      child: Column(
        children: [
          vSpace(height: 24),
          Row(
            children: [
              ValueListenableBuilder<List<City>>(
                valueListenable: homeNotifier.cityList,
                builder: (context, value, child) {
                  return DropdownButton<String>(
                    value: _selectedCity,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        _selectedCity = value!;
                      });
                      _getWeather();
                    },
                    items: value.map<DropdownMenuItem<String>>((City value) {
                      return DropdownMenuItem<String>(
                        value: value.id,
                        child: Text("${value.name} ${value.maxTemperature ?? ''}/${value.minTemperature ?? ''}"),
                      );
                    }).toList(),
                  );
                },
              ),
              /*Row(
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
              ),*/
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
          ..._listData(),
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
                      InkWell(
                        onTap: _doLogout,
                        child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                              color: redColor,
                              border: Border.all(
                                color: redColor,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(15))),
                          child: const Center(
                            child: Text(
                              "Logout",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      hSpace(),
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                              color: negativeButtonColor,
                              border: Border.all(
                                color: negativeButtonColor,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(15))),
                          child: const Center(
                            child: Text(
                              "Cancel",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
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
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(35.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
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
                            borderRadius: const BorderRadius.all(Radius.circular(15))),
                        child: const Center(
                          child: Text(
                            "Logout",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
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
                            borderRadius: const BorderRadius.all(Radius.circular(15))),
                        child: const Center(
                          child: Text(
                            "Cancel",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
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

  void _doLogout() {
    SharedPref.setToken("");
    Navigator.of(context).pop();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
        (route) => false);
  }

  void _getWeather() {
    if (_selectedCity != null) {
      homeNotifier.getCityWeather(_selectedCity!);
    }
  }

  _listData() {
    List<Widget> list = [];
    if (_selectedCity == null) {
      list.add(Expanded(
          child: Center(
        child: header("Please select a city", color: Colors.white, isBold: false),
      )));
    } else if (homeNotifier.weatherData != null) {
      list.add(Flexible(
        child: Image.asset(
          homeNotifier.weatherData != null ? WeatherTypeHelpers.fromAlias(homeNotifier.weatherData!.condition!)!.icon : WeatherType.cloudy.icon,
        ),
      ));
      list.add(Container(
        padding: EdgeInsets.all(8),
        width: double.infinity,
        decoration: whiteBackgroundWithBorder(),
        child: Column(
          children: [
            header("Today, ${DateFormat.yMMMd().format(DateTime.now())}", color: Colors.white, isBold: false),
            ShadowText(
              homeNotifier.weatherData!.temperature.toString().toTemp(),
              style: Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.white, fontSize: 70),
            ),
            header(weather.displayName, color: Colors.white),
            vSpace(),
            _weatherDetail("Temperature", homeNotifier.weatherData!.temperature.toString().toTemp()),
            _weatherDetail("MaxTemperature", homeNotifier.weatherData!.maxTemperature.toString().toTemp()),
            _weatherDetail("MinTemperature", homeNotifier.weatherData!.minTemperature.toString().toTemp()),
            _weatherDetail("Condition", homeNotifier.weatherData!.condition!),
            _weatherDetail("WindSpeed", "${homeNotifier.weatherData!.windSpeed!} km/h"),
            _weatherDetail("Humidity", "${homeNotifier.weatherData!.humidity!} %"),
          ],
        ),
      ));
      list.add(vSpace());
      list.add(button(
        "Forecast Report ",
        icon: const Icon(
          Icons.arrow_forward_ios_outlined,
          size: 20,
          color: buttonTextColor,
        ),
        horizontalMargin: 50,
        onTap: () => Navigator.of(context).pushNamed(WeatherScreen.route, arguments: _selectedCity),
      ));
    } else {
      list.add(Expanded(
          child: Center(
        child: header("No data available", color: Colors.white, isBold: false),
      )));
    }
    return list;
  }
}
