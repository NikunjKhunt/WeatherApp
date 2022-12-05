import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:weatherapp/models/City.dart';
import 'package:weatherapp/models/CityRes.dart';
import 'package:weatherapp/models/WeatherRes.dart';
import 'package:weatherapp/utils/api_wrapper.dart';
import 'package:weatherapp/utils/constants.dart';
import 'package:weatherapp/utils/shared_pref.dart';

class HomeNotifier extends ChangeNotifier {
  // ValueNotifier<ApiStatus> progressBar = ValueNotifier(ApiStatus.pending);
  ValueNotifier<ApiStatus> progressBar = ValueNotifier(ApiStatus.pending);
  ValueNotifier<List<City>> cityList = ValueNotifier([]);
  WeatherData? weatherData;

  fetchData(String cityId) async {
    progressBar.value = ApiStatus.processing;
    Future.wait([
      getCities(),
      getCityWeather(cityId)
    ]).then((value) {
      progressBar.value = ApiStatus.complete;
    });
  }

  Future<bool> getCities() async {

    try {
      final cityRes = await SharedPref.getCityRes();
      if (cityRes.isNotEmpty) {
        CityRes? resObj = CityRes.fromJson(json.decode(cityRes));
        cityList.value.clear();
        cityList.value = (resObj.list ?? []);
      }
      final resp = await ApiWrapper().doGet(Cons.city_list, {});
      if (resp != null) {
        SharedPref.setCityRes(json.encode(resp));
        if (cityRes.isEmpty) {
          CityRes? resObj = CityRes.fromJson(resp);
          cityList.value.clear();
          cityList.value = (resObj.list ?? []);
        }
        return true;
      }
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  Future<bool> getCityWeather(String cityId) async {
    progressBar.value = ApiStatus.processing;
    try {
      final resp = await ApiWrapper().doGet("${Cons.live_weather}/$cityId", {});
      if (resp != null) {
        WeatherRes? resObj = WeatherRes.fromJson(resp);
        weatherData = resObj.data;
        progressBar.value = ApiStatus.complete;
        return true;
      }
    } catch (e) {
      progressBar.value = ApiStatus.error;
      print(e.toString());
    }
    return false;
  }
}
