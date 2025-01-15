import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService{
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> setString(String key, String? value) async {
    SharedPreferences prefs = await _prefs;
    if (value != null && value.isNotEmpty) {
      prefs.setString(key, value);
    }
  }
  Future<void> setRememberMe(String key, bool? value) async {
    SharedPreferences prefs = await _prefs;
    if (value != null) {
      prefs.setBool(key, value);
    }
  }
  Future<void> setTmaId(String key, String? value) async {
    SharedPreferences prefs = await _prefs;
    if (value != null && value.isNotEmpty) {
      prefs.setString(key, value);
    }
  }
  Future<void> setUserId(String key, String? value) async {
    SharedPreferences prefs = await _prefs;
    if (value != null && value.isNotEmpty) {
      prefs.setString(key, value);
    }
  }

  Future<String?> getString(String key) async {
    SharedPreferences prefs = await _prefs;
    return prefs.containsKey(key) ? prefs.getString(key) : "";
  }
  Future<String?> getUserId(String key) async {
    SharedPreferences prefs = await _prefs;
    return prefs.containsKey(key) ? prefs.getString(key) : "";
  }
  Future<String?> getTmaId(String key) async {
    SharedPreferences prefs = await _prefs;
    return prefs.containsKey(key) ? prefs.getString(key) : "";
  }
  getRememberMe(String key) async {
    SharedPreferences prefs = await _prefs;
    return prefs.containsKey(key) ? prefs.getBool(key) : false;
  }
  Future<String?> remove(String key,value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.remove(value);
    await prefs.clear();
  }
  Future<String?> removeTmaId(String key,value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.remove(value.toString());
    await prefs.clear();
  }
  Future<String?> removeUserId(String key,value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.clear();
  }
}