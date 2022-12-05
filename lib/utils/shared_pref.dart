
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  static const String ACCESS_TOKEN = "ACCESS_TOKEN";
  static const String DEFAULT_CITY = "DEFAULT_CITY";
  static const String REMEMBER_ME = "REMEMBER_ME";
  static const String CITY_RES = "CITY_RES";

  static Future<SharedPreferences> _getPref() async {
    return await SharedPreferences.getInstance();
  }

  static setToken(String accessToken) async {
    var pref = await _getPref();
    pref.setString(ACCESS_TOKEN, accessToken);
  }

  static Future<String> getAccessToken() async {
    var pref = await _getPref();
    return pref.getString(ACCESS_TOKEN) ?? '';
  }
  static setDefaultCity(String value) async {
    var pref = await _getPref();
    pref.setString(DEFAULT_CITY, value);
  }

  static Future<String> getDefaultCity() async {
    var pref = await _getPref();
    return pref.getString(DEFAULT_CITY) ?? '635fc8958d6a93e831acd3c9';
  }
  static setCityRes(String accessToken) async {
    var pref = await _getPref();
    pref.setString(CITY_RES, accessToken);
  }

  static Future<String> getCityRes() async {
    var pref = await _getPref();
    return pref.getString(CITY_RES) ?? '';
  }
    static setRememberMe(bool value) async {
    var pref = await _getPref();
    pref.setBool(REMEMBER_ME, value);
  }

  static Future<bool> isRememberMe() async {
    var pref = await _getPref();
    return pref.getBool(REMEMBER_ME) ?? false ;
  }


}