import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({@required this.sharedPreferences});

  static const DAILY_TRENDING = 'DAILY_TRENDING';

  Future<bool> get isDailyTrending async {
    final prefs = await sharedPreferences;
    return prefs.getBool(DAILY_TRENDING) ?? false;
  }

  void setDailyTrending(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DAILY_TRENDING, value);
  }
}
