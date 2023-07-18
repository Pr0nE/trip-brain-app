abstract class CacheManager {
  Future<String?> getJsonData(String key, {String? table});
  void saveJsonData(String key, String value, {String? table});

  Future<Map<String, String>> getTableEntries(String tableKey);
}
