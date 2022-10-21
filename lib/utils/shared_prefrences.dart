import 'package:shared_preferences/shared_preferences.dart';

class Prefrences {
  Future<dynamic> getSharedPreferenceValue(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }

  Future<void> setSharedPreferenceValue(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  // Future<dynamic> getSharedPreferenceBoolValue(String key) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   return preferences.getBool(key);
  // }

  // Future<void> setSharedPreferenceBoolValue(String key, bool value) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setBool(key, value);
  // }
  Future<void> setSharedPreferenceListValue(
    String key,
    List<String> value,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList(key, value);
  }

  Future<List<String>> getSharedPreferenceListValue(
    String key,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList(key) ?? [];
  }

  // Future<void> removeSharedPreferenceValue(String key) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.remove(key);
  // }

  Future<dynamic> removeSharedPreferenceValue(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(key);
  }
}
