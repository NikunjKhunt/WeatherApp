import 'package:flutter/foundation.dart';

class Cons {
  static const double space = 16;
  static const String baseURL = "https://hiring-test.a2dweb.com/";

  //POST
  static const String create_user = "create-user";
  static const String login = "login";

  //GET
  static const String city_list = "city-list";
  static const String view_small_forecast = "view-small-forecast";
  static const String view_other_forecast = "view-other-forecast";
  static const String live_weather = "live-weather";
}

enum ApiStatus { pending, processing, complete, error }

enum WeatherType { sunny, partlyCloudy, cloudy, rainy, snow, stormy, thunder }

extension WeatherTypeHelpers on WeatherType {
  static const _names = <WeatherType, String>{
    WeatherType.sunny: 'Sunny',
    WeatherType.partlyCloudy: 'PartlyCloudy',
    WeatherType.cloudy: 'Cloudy',
    WeatherType.rainy: 'Rainy',
    WeatherType.snow: 'Snow',
    WeatherType.stormy: 'Stormy',
    WeatherType.thunder: 'Thunder',
  };
  static const _alias = <WeatherType, String>{
    WeatherType.sunny: 'sunny',
    WeatherType.partlyCloudy: 'partly-cloudy',
    WeatherType.cloudy: 'cloudy',
    WeatherType.rainy: 'rainy',
    WeatherType.snow: 'snow',
    WeatherType.stormy: 'windy',
    WeatherType.thunder: 'thunder',
  };

  static const _icons = <WeatherType, String>{
    WeatherType.sunny: 'assets/images/sunny.webp',
    WeatherType.partlyCloudy: 'assets/images/partly_cloudy.webp',
    WeatherType.cloudy: 'assets/images/cloudy.webp',
    WeatherType.rainy: 'assets/images/rainy.webp',
    WeatherType.snow: 'assets/images/snow.webp',
    WeatherType.stormy: 'assets/images/stormy.webp',
    WeatherType.thunder: 'assets/images/thunder.webp',
  };

  String get displayName => _names[this] ?? ref;

  String get alias => _alias[this] ?? ref;

  String get icon => _icons[this] ?? ref;

  String get ref => describeEnum(this);

  static final Map<String, WeatherType> _lookupNames = {for (var optionType in WeatherType.values) optionType.displayName: optionType};
  static final Map<String, WeatherType> _lookupAlias = {for (var optionType in WeatherType.values) optionType.alias: optionType};
  static final Map<String, WeatherType> _lookupRefs = {for (var optionType in WeatherType.values) optionType.ref: optionType};

  static WeatherType? fromDisplayName(String displayName) {
    return _lookupNames[displayName];
  }

  static WeatherType? fromAlias(String alias) {
    return _lookupAlias[alias];
  }

  static WeatherType? fromRef(String ref) {
    return _lookupRefs[ref];
  }
}
