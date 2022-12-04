class LoginRes {
  LoginRes({
      String? msg, 
      String? token, 
      LiveWeather? liveWeather,}){
    _msg = msg;
    _token = token;
    _liveWeather = liveWeather;
}

  LoginRes.fromJson(Map<String,dynamic> json) {
    _msg = json['msg'];
    _token = json['token'];
    _liveWeather = json['liveWeather'] != null ? LiveWeather.fromJson(json['liveWeather']) : null;
  }
  String? _msg;
  String? _token;
  LiveWeather? _liveWeather;
LoginRes copyWith({  String? msg,
  String? token,
  LiveWeather? liveWeather,
}) => LoginRes(  msg: msg ?? _msg,
  token: token ?? _token,
  liveWeather: liveWeather ?? _liveWeather,
);
  String? get msg => _msg;
  String? get token => _token;
  LiveWeather? get liveWeather => _liveWeather;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    map['token'] = _token;
    if (_liveWeather != null) {
      map['liveWeather'] = _liveWeather?.toJson();
    }
    return map;
  }

}

class LiveWeather {
  LiveWeather({
      String? time, 
      int? temperature, 
      int? maxTemperature, 
      int? minTemperature, 
      String? condition, 
      int? windSpeed, 
      int? humidity, 
      String? cityId,}){
    _time = time;
    _temperature = temperature;
    _maxTemperature = maxTemperature;
    _minTemperature = minTemperature;
    _condition = condition;
    _windSpeed = windSpeed;
    _humidity = humidity;
    _cityId = cityId;
}

  LiveWeather.fromJson(dynamic json) {
    _time = json['time'];
    _temperature = json['temperature'];
    _maxTemperature = json['maxTemperature'];
    _minTemperature = json['minTemperature'];
    _condition = json['condition'];
    _windSpeed = json['windSpeed'];
    _humidity = json['humidity'];
    _cityId = json['cityId'];
  }
  String? _time;
  int? _temperature;
  int? _maxTemperature;
  int? _minTemperature;
  String? _condition;
  int? _windSpeed;
  int? _humidity;
  String? _cityId;
LiveWeather copyWith({  String? time,
  int? temperature,
  int? maxTemperature,
  int? minTemperature,
  String? condition,
  int? windSpeed,
  int? humidity,
  String? cityId,
}) => LiveWeather(  time: time ?? _time,
  temperature: temperature ?? _temperature,
  maxTemperature: maxTemperature ?? _maxTemperature,
  minTemperature: minTemperature ?? _minTemperature,
  condition: condition ?? _condition,
  windSpeed: windSpeed ?? _windSpeed,
  humidity: humidity ?? _humidity,
  cityId: cityId ?? _cityId,
);
  String? get time => _time;
  int? get temperature => _temperature;
  int? get maxTemperature => _maxTemperature;
  int? get minTemperature => _minTemperature;
  String? get condition => _condition;
  int? get windSpeed => _windSpeed;
  int? get humidity => _humidity;
  String? get cityId => _cityId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = _time;
    map['temperature'] = _temperature;
    map['maxTemperature'] = _maxTemperature;
    map['minTemperature'] = _minTemperature;
    map['condition'] = _condition;
    map['windSpeed'] = _windSpeed;
    map['humidity'] = _humidity;
    map['cityId'] = _cityId;
    return map;
  }

}