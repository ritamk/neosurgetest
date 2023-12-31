import 'package:shared_preferences/shared_preferences.dart';

class LocalSharedPref {
  static SharedPreferences? sharedPreferences;

  static Future init() async =>
      sharedPreferences = await SharedPreferences.getInstance();

  static Future<bool> setLoggedIn(bool isLoggedIn) async =>
      await sharedPreferences!.setBool('isLoggedIn', isLoggedIn);

  static bool getLoggedIn() {
    try {
      return sharedPreferences!.getBool('isLoggedIn') ?? false;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> setUid(String uid) async =>
      await sharedPreferences!.setString('uid', uid);

  static String? getUid() {
    try {
      final String? user = sharedPreferences!.getString('uid');
      return user;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> clearSharedPref() async =>
      await sharedPreferences!.clear();
}
