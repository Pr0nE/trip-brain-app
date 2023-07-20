abstract class Storage {
  Future<void> save(String key, String data);
  Future<String?> get(String key);
  Future<void> clear(String key);
}
