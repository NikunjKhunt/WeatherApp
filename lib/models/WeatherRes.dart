
class WeatherRes {
  WeatherRes({
      this.status, 
      this.msg, 
      this.data,});

  WeatherRes.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? WeatherData.fromJson(json['data']) : null;
  }
  bool? status;
  String? msg;
  WeatherData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    return map;
  }

}

class WeatherData {
  WeatherData({
    this.temperature,
    this.maxTemperature,
    this.minTemperature,
    this.condition,
    this.windSpeed,
    this.humidity,
    this.cityId,});

  WeatherData.fromJson(Map<String,dynamic> json) {
    temperature = json['temperature'];
    maxTemperature = json['maxTemperature'];
    minTemperature = json['minTemperature'];
    condition = json['condition'];
    windSpeed = json['windSpeed'];
    humidity = json['humidity'];
    cityId = json['cityId'];
  }
  int? temperature;
  int? maxTemperature;
  int? minTemperature;
  String? condition;
  int? windSpeed;
  int? humidity;
  String? cityId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['temperature'] = temperature;
    map['maxTemperature'] = maxTemperature;
    map['minTemperature'] = minTemperature;
    map['condition'] = condition;
    map['windSpeed'] = windSpeed;
    map['humidity'] = humidity;
    map['cityId'] = cityId;
    return map;
  }

}