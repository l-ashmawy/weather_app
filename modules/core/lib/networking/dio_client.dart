import 'package:core/cache/preference_manager.dart';
import 'package:core/networking/networking.dart';
import 'package:dependencies/dependencies.dart';

class DioClient {

  DioClient();
  final ApiConfigurations configurations = ApiConfigurations();

  Dio get dio => _getDio();

  Dio _getDio() {
    final options = BaseOptions(
      baseUrl: configurations.baseUrlProd,
      connectTimeout: const Duration(milliseconds: 50000),
      receiveTimeout: const Duration(milliseconds: 30000),
    );
    final dio = Dio(options);
    return dio;
  }
}

