
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  static const String ACCESS_TOKEN = "ACCESS_TOKEN";

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
}