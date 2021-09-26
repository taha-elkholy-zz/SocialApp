import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  // A static variable from SharedPreferences
  // to be used in all the app
  static late SharedPreferences sharedPreferences;

  // init SharedPreferences
  // this method must be called before runApp method
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // get any type of data from SharedPreferences
  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  // Remove any object data from shared preferences
  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  // method for set all data type on shared preferences object
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    return await sharedPreferences.setDouble(key, value);
  }
}
