import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:the_baetles_chord_play/datas/models/user.dart';

class LocalDataSource {
  static final LocalDataSource _instance = LocalDataSource._internal();
  late final Future<void> _isInitialized; // 로컬 소스와 연결되면 complete됨.
  late final SharedPreferences _sharedPref;

  factory LocalDataSource() {
    return _instance;
  }

  LocalDataSource._internal() {
    _isInitialized = _loadSharedPreferences();
  }

  Future<void> _loadSharedPreferences() async {
    _sharedPref = await SharedPreferences.getInstance();
  }

  Future<void> get isInitialized => _isInitialized;

  Future<User?> fetchUser() async {
    await _isInitialized;

    String? data = _sharedPref.getString("user");

    if (data == null) {
      return null;    // 유저 데이터가 없으면 null 반환
    }

    User user;

    try {
      user = User.fromJson(jsonDecode(data));
    } catch (e) {
      return null;    // 데이터가 유효하지 않으면 null 반환
    }

    return user;
  }

  void storeSharedPreference(String key, String value) {
    _sharedPref.setString(key, value);
  }
}
