import 'package:flutter/widgets.dart';
import 'package:weatherapp/models/LoginRes.dart';
import 'package:weatherapp/utils/api_wrapper.dart';
import 'package:weatherapp/utils/constants.dart';
import 'package:weatherapp/utils/shared_pref.dart';

class LoginNotifier extends ChangeNotifier {

  ValueNotifier<bool> isProgressing = ValueNotifier(false);
  String message = "";

  Future<bool> doLogin({required String emailAddress, required String password}) async {
    isProgressing.value = true;
    Map<String, dynamic> data = {
      "email": "nikunj@yopmail.com",
      "password": "Qweasd@123",
    };
    try {
      final resp = await ApiWrapper().doPost(Cons.login, data, false);
      if (resp != null) {
        LoginRes? loginRes = LoginRes.fromJson(resp);
        await SharedPref.setToken(loginRes.token??'');
        message =  loginRes.msg ?? '';
        isProgressing.value = false;
        return resp["status"];
      }
    } catch (e) {
      print(e.toString());
    }
    isProgressing.value = false;
    return false;
  }
  Future<bool> doSignUp({required String name,required String emailAddress,required String phoneNumber,required String country, required String password}) async {
    isProgressing.value = true;
    Map<String, dynamic> data = {
      "name": name,
      "email": emailAddress.trim(),
      "phone": phoneNumber,
      "country": country,
      "password": password,
    };
    try {
      final resp = await ApiWrapper().doPost(Cons.create_user, data, false);
      if (resp != null && resp.isNotEmpty) {
        message =  resp["status"]?resp["msg"]:resp["message"];
        isProgressing.value = false;
        return resp["status"];
      }
    } catch (e) {
      print(e.toString());
    }
    isProgressing.value = false;
    return false;
  }
}
