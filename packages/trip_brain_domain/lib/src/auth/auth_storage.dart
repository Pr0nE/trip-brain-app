abstract class AuthStorage {
  Future<String?> getAccessToken();
  Future<void> saveAccessToken(String token);
}
