import 'package:shared_preferences/shared_preferences.dart';

import 'package:pvpn/util/app.dart';

class SplashModel {
  int loginCount = 0;

  Future<void> onLoad() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    loginCount = preferences.getInt(PreferencesKeys.loginCount) ?? 0;
  }
}