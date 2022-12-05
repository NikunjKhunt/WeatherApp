
class OtherWeatherRes {
  OtherWeatherRes({
      this.status, 
      this.data,});

  OtherWeatherRes.fromJson(dynamic json) {
    status = json['status'];
    data = json['DATA'] != null ? OtherWeatherData.fromJson(json['DATA']) : null;
  }
  bool? status;
  OtherWeatherData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['DATA'] = data!.toJson();
    }
    return map;
  }

}

class OtherWeatherData {
  OtherWeatherData({
    this.day1,
    this.day2,
    this.day3,
    this.day4,
    this.day5,
    this.day6,
    this.day7,
    this.cityId,});

  OtherWeatherData.fromJson(dynamic json) {
    day1 = json['day1'] != null ? OtherWeatherDay.fromJson(json['day1']) : null;
    day2 = json['day2'] != null ? OtherWeatherDay.fromJson(json['day2']) : null;
    day3 = json['day3'] != null ? OtherWeatherDay.fromJson(json['day3']) : null;
    day4 = json['day4'] != null ? OtherWeatherDay.fromJson(json['day4']) : null;
    day5 = json['day5'] != null ? OtherWeatherDay.fromJson(json['day5']) : null;
    day6 = json['day6'] != null ? OtherWeatherDay.fromJson(json['day6']) : null;
    day7 = json['day7'] != null ? OtherWeatherDay.fromJson(json['day7']) : null;
    cityId = json['cityId'];
  }
  OtherWeatherDay? day1;
  OtherWeatherDay? day2;
  OtherWeatherDay? day3;
  OtherWeatherDay? day4;
  OtherWeatherDay? day5;
  OtherWeatherDay? day6;
  OtherWeatherDay? day7;
  String? cityId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (day1 != null) {
      map['day1'] = day1!.toJson();
    }
    if (day2 != null) {
      map['day2'] = day2!.toJson();
    }
    if (day3 != null) {
      map['day3'] = day3!.toJson();
    }
    if (day4 != null) {
      map['day4'] = day4!.toJson();
    }
    if (day5 != null) {
      map['day5'] = day5!.toJson();
    }
    if (day6 != null) {
      map['day6'] = day6!.toJson();
    }
    if (day7 != null) {
      map['day7'] = day7!.toJson();
    }
    map['cityId'] = cityId;
    return map;
  }

}

class OtherWeatherDay {
  OtherWeatherDay({
    this.temperature,
    this.condition,});

  OtherWeatherDay.fromJson(dynamic json) {
    temperature = json['temperature'];
    condition = json['condition'];
  }
  int? temperature;
  String? condition;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['temperature'] = temperature;
    map['condition'] = condition;
    return map;
  }

}