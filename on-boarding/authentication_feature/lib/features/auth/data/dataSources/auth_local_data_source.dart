import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage storage;

  AuthLocalDataSourceImpl(this.storage);

  static const tKey = 'auth_token';
  @override
  Future<void> clearToken() async {
    await storage.delete(key: tKey);
  }

  @override
  Future<String?> getToken() async {
    return await storage.read(key: tKey);
  }

  @override
  Future<void> saveToken(String token) async {
    await storage.write(key: tKey, value: token);
  }

}