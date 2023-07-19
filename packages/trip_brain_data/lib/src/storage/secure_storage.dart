import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';

class SecureStorage implements StringStorage {
  final _storage = FlutterSecureStorage();

  @override
  Future<String?> get(String key) => _storage.read(key: key);

  @override
  Future<void> save(String key, String data) =>
      _storage.write(key: key, value: data);

  @override
  Future<void> clear(String key) => _storage.delete(key: key);
}
