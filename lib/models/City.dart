class City {
  City({
      this.id, 
      this.name, 
      this.state, 
      this.country, 
      this.maxTemperature, 
      this.minTemperature,});

  City.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    state = json['state'];
    country = json['country'];
    maxTemperature = json['maxTemperature'];
    minTemperature = json['minTemperature'];
  }
  String? id;
  String? name;
  String? state;
  String? country;
  int? maxTemperature;
  int? minTemperature;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['state'] = state;
    map['country'] = country;
    map['maxTemperature'] = maxTemperature;
    map['minTemperature'] = minTemperature;
    return map;
  }

}