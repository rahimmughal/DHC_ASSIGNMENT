import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefConfig {
  static SharedPreferences? pref;

  static Future<void> initialize() async {
    pref = await SharedPreferences.getInstance();
  }
}
