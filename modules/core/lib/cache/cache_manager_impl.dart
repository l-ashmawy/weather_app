// ignore_for_file: depend_on_referenced_packages

import 'package:dependencies/dependencies.dart';

import 'cache_manger.dart';

class CacheManagerImpl implements CacheManager {

  var box = Hive.box('weather');

  @override
  void saveValue(String cachingKey, String  value) async {
    box.put(cachingKey, value);
  }

  @override
  Future<String> getValue(String cachingKey) async {
    if (box.containsKey(cachingKey)){
      return box.get(cachingKey);
    }
    throw Exception("$cachingKey does not exist");
  }
}
