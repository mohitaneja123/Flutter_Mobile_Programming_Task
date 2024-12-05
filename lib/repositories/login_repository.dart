import '../local_storage_service.dart';

class LoginRepository {
  final LocalStorageService _localStorageService;

  LoginRepository({LocalStorageService? localStorageService})
      : _localStorageService = localStorageService ?? LocalStorageService();

  Future<bool> authenticate({
    required String username,
    required String password,
    required bool isRemember,
  }) async {
    if (username == 'username' && password == 'password') {
      await _localStorageService.setToken('dummy_token');
      await _localStorageService.setIsRemember(isRemember);
      return true;
    }
    return false;
  }

  Future<String?> getToken() async {
    return await _localStorageService.getToken();
  }

  Future<bool> isRemember() async {
    return await _localStorageService.isRemember();
  }

  Future<void> clearToken() async {
    await _localStorageService.clearData();
  }
}
