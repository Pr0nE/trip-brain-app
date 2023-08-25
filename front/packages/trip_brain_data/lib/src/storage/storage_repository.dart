import 'package:trip_brain_domain/trip_brain_domain.dart';

class AppLocalRepository implements AuthStorage {
  AppLocalRepository({required this.storage});

  final Storage storage;

  static const _accessTokenKey = 'AccessTokenKey';

  @override
  Future<void> saveAccessToken(String token) async =>
      await storage.save(_accessTokenKey, token);

  @override
  Future<String?> getAccessToken() => storage.get(_accessTokenKey);

  @override
  Future<void> clearAccessToken() => storage.clear(_accessTokenKey);
}
