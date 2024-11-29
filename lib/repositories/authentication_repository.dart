import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  static String tokenKey = 'token';
  static String isRememberKey = 'isremember';

  Future<bool> authenticate({
    required String username,
    required String password,
    required bool isRemember,
  }) async {
    if (username == 'username' && password == 'password') {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(tokenKey, 'dummy_token');
      await prefs.setBool(isRememberKey, isRemember);
      return true;
    }
    return false;
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  Future<bool> isRemember() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isRememberKey) ?? false;
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
    await prefs.remove(isRememberKey);
  }
}
