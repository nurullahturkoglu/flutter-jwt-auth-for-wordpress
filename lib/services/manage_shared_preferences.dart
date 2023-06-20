import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ManageSharedPreferences {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static Future<void> clearSharedPrefs() async {
    SharedPreferences prefs = await _prefs;
    await prefs.clear();
  }

  static Future<bool> isDatabaseDownloaded() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getBool('databaseDownloaded') ?? false;
  }

  static Future<void> setDatabaseDownloaded() async {
    SharedPreferences prefs = await _prefs;
    await prefs.setBool('databaseDownloaded', true);
  }

  static Future<bool> isAppFirstOpen() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getBool('appFirstOpen') ?? true;
  }

  static Future<void> setAppFirstOpen() async {
    SharedPreferences prefs = await _prefs;
    await prefs.setBool('appFirstOpen', false);
  }

  static Future<void> saveUser(Map<String, dynamic> user) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString('user', json.encode(user));
  }

  static Future<Map<String, dynamic>?> getUser() async {
    SharedPreferences prefs = await _prefs;
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      return json.decode(userJson) as Map<String, dynamic>;
    }
    return null;
  }

  static Future<void> clearUser() async {
    SharedPreferences prefs = await _prefs;
    await prefs.remove('user');
  }
}
