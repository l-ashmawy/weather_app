abstract class CacheManager {
  void saveValue(String cachingKey, String value);

  Future<String> getValue(String cachingKey);
}
