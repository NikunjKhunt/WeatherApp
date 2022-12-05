import 'package:weatherapp/models/City.dart';

class CityRes {
  CityRes({
      this.msg, 
      this.list,});

  CityRes.fromJson(Map<String,dynamic> json) {
    msg = json['msg'];
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list?.add(City.fromJson(v));
      });
    }
  }
  String? msg;
  List<City>? list;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = msg;
    if (list != null) {
      map['list'] = list!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}