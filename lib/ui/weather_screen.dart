import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/notifiers/weather_notifier.dart';
import 'package:weatherapp/utils/colors.dart';
import 'package:weatherapp/utils/constants.dart';
import 'package:weatherapp/utils/extentions.dart';
import 'package:weatherapp/utils/widgets/common.dart';
import 'package:provider/provider.dart';

class WeatherScreen extends StatefulWidget {
  static const String route = "/weather-screen";
  final String? cityId;
  const WeatherScreen({Key? key,this.cityId}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  DateTime now = DateTime.now();
  late WeatherNotifier notifier;
  @override
  void initState() {
    super.initState();
    notifier = Provider.of<WeatherNotifier>(context, listen: false);
    notifier.fetchData(widget.cityId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder<ApiStatus>(
          valueListenable: notifier.progressBar,
          builder: (context, value, child) {
            return Stack(
              children: [
                _body(),
                if (value == ApiStatus.processing)
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: whiteColor70,
                    child: const Center(
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

  _body() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(Cons.space),
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
          if(notifier.smallWeatherData.isNotEmpty)
          SizedBox(
            height: 170,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(10, (index) => HWeatherItem(temp: notifier.smallWeatherData["temperature"].toString(), weatherType: notifier.smallWeatherData["condition"], time: notifier.smallWeatherData["time"]/*DateFormat.jm().format(DateFormat.jm().parse().add(Duration(minutes: index*30)))*/)).toList(),
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
          if(notifier.weatherData!=null)
          Flexible(
            child: SingleChildScrollView(
              child: /*
             TODO Had to remove cause of API Response

              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return VWeatherItem(temp: "20", weatherType: "Sunny", time: "Sep, 13");
                  })*/
              Column(children: [
                VWeatherItem(temp: notifier.weatherData!.day1!.temperature.toString(), weatherType: notifier.weatherData!.day1!.condition!, time: DateFormat("MMM, dd").format(now.add(Duration(days: 1)))),
                VWeatherItem(temp: notifier.weatherData!.day2!.temperature.toString(), weatherType: notifier.weatherData!.day1!.condition!, time: DateFormat("MMM, dd").format(now.add(Duration(days: 2)))),
                VWeatherItem(temp: notifier.weatherData!.day3!.temperature.toString(), weatherType: notifier.weatherData!.day1!.condition!, time: DateFormat("MMM, dd").format(now.add(Duration(days: 3)))),
                VWeatherItem(temp: notifier.weatherData!.day4!.temperature.toString(), weatherType: notifier.weatherData!.day1!.condition!, time: DateFormat("MMM, dd").format(now.add(Duration(days: 4)))),
                VWeatherItem(temp: notifier.weatherData!.day5!.temperature.toString(), weatherType: notifier.weatherData!.day1!.condition!, time: DateFormat("MMM, dd").format(now.add(Duration(days: 5)))),
                VWeatherItem(temp: notifier.weatherData!.day6!.temperature.toString(), weatherType: notifier.weatherData!.day1!.condition!, time: DateFormat("MMM, dd").format(now.add(Duration(days: 6)))),
                VWeatherItem(temp: notifier.weatherData!.day7!.temperature.toString(), weatherType: notifier.weatherData!.day1!.condition!, time: DateFormat("MMM, dd").format(now.add(Duration(days: 7)))),
              ],),
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
            WeatherTypeHelpers.fromAlias(weatherType)?.icon ?? WeatherType.cloudy.icon,
            height: 75,
          ),
          Padding(padding: EdgeInsets.all(5),child:
          header(time, color: Colors.white, isBold: false,fontSize: 20),),
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
    print(WeatherTypeHelpers.fromAlias(weatherType)?.icon);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          header(time, color: Colors.white, isBold: false),
          Image.asset(
            WeatherTypeHelpers.fromAlias(weatherType)?.icon ?? WeatherType.cloudy.icon,
            height: 50,
          ),
          header(temp.toTemp(), color: Colors.white, isBold: false),
        ],
      ),
    );
  }
}
