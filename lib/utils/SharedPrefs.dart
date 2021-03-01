/*
 * Product by Swing Technologies.
 * Copyright (c) 1/3/2021.
 * Developed by Debojyoti Singha
 */

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  static bool saveStringData(String key, String value) {
    if (_sharedPrefs == null) {
      return false;
    }
    _sharedPrefs.setString(key, value);
    return true;
  }

  static String getStringData(String key) {
    if (_sharedPrefs == null) {
      return null;
    }
    return _sharedPrefs.getString(key);
  }

  static bool saveAccessToken(String token) {
    if (_sharedPrefs == null) {
      return false;
    }
    _sharedPrefs.setString("token", token);
    return true;
  }

  static String getAccessToken() {
    if (_sharedPrefs == null) {
      return null;
    }
    return _sharedPrefs.getString("token");
  }

  static bool saveUserState(bool state) {
    if (_sharedPrefs == null) {
      return false;
    }
    _sharedPrefs.setBool("userState", state);
    return true;
  }

  static bool getUserState() {
    if (_sharedPrefs == null) {
      return null;
    }
    return _sharedPrefs.getBool("userState");
  }
}
