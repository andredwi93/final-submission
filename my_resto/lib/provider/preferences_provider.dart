import 'package:flutter/foundation.dart';
import 'package:my_resto/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({@required this.preferencesHelper}) {
    _getDailyTrending();
  }

  bool _isDailyTrendingActive = false;
  bool get isDailyTrendingActive => _isDailyTrendingActive;

  void _getDailyTrending() async {
    _isDailyTrendingActive = await preferencesHelper.isDailyTrending;
    notifyListeners();
  }

  void enableDailyTrending(bool value) {
    preferencesHelper.setDailyTrending(value);
    _getDailyTrending();
  }
}
