import 'package:flutter/widgets.dart';
import 'package:weatherapp/models/City.dart';
import 'package:weatherapp/models/OtherWeather.dart';
import 'package:weatherapp/utils/api_wrapper.dart';
import 'package:weatherapp/utils/constants.dart';

class WeatherNotifier extends ChangeNotifier {
  ValueNotifier<ApiStatus> progressBar = ValueNotifier(ApiStatus.pending);
  ValueNotifier<List<City>> cityList = ValueNotifier([]);
  OtherWeatherData? weatherData;
  Map<String, dynamic> smallWeatherData = {};

  fetchData(String cityId) async {
    progressBar.value = ApiStatus.processing;
    // await getSmallWeather(cityId);
    Future.wait([
     getSmallWeather(cityId),
     getOtherWeather(cityId)
    ]).then((value) {
      progressBar.value = ApiStatus.complete;
    });
  }

  Future<bool> getSmallWeather(String cityId) async {
    try {
      // final Map res = await ApiWrapper().doGet("${Cons.view_small_forecast}/$cityId", {}); TODO Not every entry has data
      final Map res = await ApiWrapper().doGet("${Cons.view_small_forecast}/635f83b2f7ccaef29c146a07", {});
      if (res != null && res.containsKey("DATA")) {
        smallWeatherData = res["DATA"];
      }
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  Future<bool> getOtherWeather(String cityId) async {
    try {
      // final resp = await ApiWrapper().doGet("${Cons.view_other_forecast}/$cityId", {}); TODO Not every entry has data
      final resp = await ApiWrapper().doGet("${Cons.view_other_forecast}/635f83b2f7ccaef29c146a07", {});
      if (resp != null) {
        OtherWeatherRes? resObj = OtherWeatherRes.fromJson(resp);
        weatherData = resObj.data;
        return true;
      }
    } catch (e) {
      print(e.toString());
    }
    return false;
  }
}
