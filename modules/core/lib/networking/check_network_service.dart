import 'package:dependencies/dependencies.dart';

class CheckNetworkService {
  Future<bool> checkNetworkService() async {
    try {
      return await InternetConnection().hasInternetAccess;
    } catch (e) {
      return false;
    }
  }
}
