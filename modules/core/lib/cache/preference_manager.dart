// ignore_for_file: depend_on_referenced_packages
import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  void saveValue(String cachingKey, String value) =>
      GetStorage().write(cachingKey, value);

  String getValue(String cachingKey) => GetStorage().read(cachingKey) as String;
}
