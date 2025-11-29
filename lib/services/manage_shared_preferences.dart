import 'package:flutter_jwt_auth/constants/storage_keys.dart';
import 'package:flutter_jwt_auth/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageSharedPreferences {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static Future<void> clearSharedPrefs() async {
    SharedPreferences prefs = await _prefs;
    await prefs.clear();
  }

  static Future<bool> isAppFirstOpen() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getBool(StorageKeys.appFirstOpen) ?? true;
  }

  static Future<void> setAppFirstOpen() async {
    SharedPreferences prefs = await _prefs;
    await prefs.setBool(StorageKeys.appFirstOpen, false);
  }

  static Future<void> saveUser(UserModel user) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString(StorageKeys.user, userModelToJson(user));
  }

  static Future<UserModel?> getUser() async {
    SharedPreferences prefs = await _prefs;
    String? userJson = prefs.getString(StorageKeys.user);
    if (userJson != null) {
      return userModelFromJson(userJson);
    }
    return null;
  }

  static Future<void> clearUserModel() async {
    SharedPreferences prefs = await _prefs;
    await prefs.remove(StorageKeys.user);
  }
}
