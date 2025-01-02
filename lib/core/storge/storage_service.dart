import 'package:get_storage/get_storage.dart';

class StorageService {
  final _box = GetStorage();
  static const _tokenKey = 'auth_token';

  Future<void> saveToken(String token) async {
    await _box.write(_tokenKey, token);
  }

  Future<String?> getToken() async {
    return _box.read(_tokenKey);
  }

  Future<void> deleteToken() async {
    await _box.remove(_tokenKey);
  }
}