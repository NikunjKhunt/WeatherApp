import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weatherapp/utils/constants.dart';
import 'package:weatherapp/utils/extentions.dart';
import 'package:weatherapp/utils/widgets/common.dart';

class WeatherScreen extends StatefulWidget {
  static const String route = "/weather-screen";

  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: _body(),
      ),
    );
  }

  _body() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(Cons.space),
      decoration: gradientBackground(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          vSpace(height: 24),
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Row(
              children: [
                const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 20,
                  color: Colors.white,
                ),
                hSpace(width: 8),
                header("Back", color: Colors.white),
              ],
            ),
          ),
          vSpace(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              header("Today", color: Colors.white, fontSize: 25),
              header(
                "Sep, 12",
                color: Colors.white,
              ),
            ],
          ),
          SizedBox(
            height: 170,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(10, (index) => HWeatherItem(temp: "20", weatherType: "Sunny", time: "15")).toList(),
            ),
          ),
          vSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              header("Next Forecast", color: Colors.white),
              Image.asset(
                "assets/images/ic_calender.webp",
                height: 25,
              ),
            ],
          ),
          // SingleChildScrollView(child: Column(children: List.generate(10, (index) => VWeatherItem(temp: "20", weatherType: "Sunny", time: "15")).toList(),))
          Flexible(
            child: SingleChildScrollView(
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return VWeatherItem(temp: "20", weatherType: "Sunny", time: "Sep, 13");
                  }),
            ),
          ),
        ],
      ),
    );
  }

}

class NextForecast extends StatelessWidget {
  const NextForecast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            header("Next Forecast", color: Colors.white),
            Image.asset(
              "assets/images/ic_calender.webp",
              height: 25,
            ),
          ],
        ),
        // SingleChildScrollView(child: Column(children: List.generate(10, (index) => VWeatherItem(temp: "20", weatherType: "Sunny", time: "15")).toList(),))
        Flexible(
          child: SingleChildScrollView(
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return VWeatherItem(temp: "20", weatherType: "Sunny", time: "Sep, 13");
                }),
          ),
        )
      ],
    );
  }
}

class HWeatherItem extends StatelessWidget {
  final String temp;
  final String weatherType;
  final String time;

  const HWeatherItem({Key? key, required this.temp, required this.weatherType, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.only(top: 8, bottom: 8),
      decoration: whiteBackgroundWithBorder(),
      child: Column(
        children: [
          header(temp.toTemp(), color: Colors.white, isBold: false),
          Image.asset(
            WeatherTypeHelpers.fromDisplayName("Cloudy")?.icon ?? "",
            height: 75,
          ),
          header(time, color: Colors.white, isBold: false),
        ],
      ),
    );
  }
}

class VWeatherItem extends StatelessWidget {
  final String temp;
  final String weatherType;
  final String time;

  const VWeatherItem({Key? key, required this.temp, required this.weatherType, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          header(time, color: Colors.white, isBold: false),
          Image.asset(
            WeatherTypeHelpers.fromDisplayName("Cloudy")?.icon ?? "",
            height: 50,
          ),
          header(temp.toTemp(), color: Colors.white, isBold: false),
        ],
      ),
    );
  }
}
