import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _tokenKey = 'token';
  static const String _isRememberKey = 'isremember';

  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> setIsRemember(bool isRemember) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isRememberKey, isRemember);
  }

  Future<bool> isRemember() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isRememberKey) ?? false;
  }

  Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_isRememberKey);
  }
}
