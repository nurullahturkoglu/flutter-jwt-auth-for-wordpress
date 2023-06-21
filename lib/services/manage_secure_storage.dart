import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  // JWT tokenini kaydetmek için kullanılır
  static Future<void> saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  // Kaydedilmiş JWT tokenini almak için kullanılır
  static Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  // Kaydedilmiş JWT tokenini silmek için kullanılır
  static Future<void> deleteToken() async {
    await _storage.delete(key: 'token');
  }
}
