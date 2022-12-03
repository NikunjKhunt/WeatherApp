import 'SignUpData.dart';

class SignupRes {
  SignupRes({
      this.status, 
      this.msg, 
      this.data,});

  SignupRes.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    data = json['DATA'] != null ? SignUpData.fromJson(json['DATA']) : null;
  }
  bool? status;
  String? msg;
  SignUpData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (data != null) {
      map['DATA'] = data!.toJson();
    }
    return map;
  }

}