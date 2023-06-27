abstract class CacheManager {
  (bool isFound, Object?) getCache(String key);
  void cache(String key, Object value);
}
