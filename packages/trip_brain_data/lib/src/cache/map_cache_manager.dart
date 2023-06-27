import 'package:trip_brain_data/src/cache/cache_manager.dart';

class MapCacheManager implements CacheManager {
  final Map<String, Object> _cacheStorage = {};

  @override
  void cache(String key, Object value) => _cacheStorage[key] = value;

  @override
  (bool isFound, Object?) getCache(String key) {
    if (_cacheStorage.containsKey(key)) {
      return (true, _cacheStorage[key]);
    }

    return (false, null);
  }
}
