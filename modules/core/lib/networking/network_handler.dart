import 'dart:developer';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

export 'package:flutter_modular/flutter_modular.dart';

class NetworkHandler {
  final Dio dio;

  NetworkHandler(this.dio);

  final preferenceManager = Modular.get<PreferenceManager>();

  Future<NetworkResponse<ResponseType>> get<ResponseType extends Mappable>(ResponseType responseType, String url,
      {var body, Map<String, String>? headers, bool isDoorBird = false, bool canLogOut = true}) async {
    var response;
    try {
      if (isDoorBird) {
        dio.options.baseUrl = "https://api.doorbird.io/";
        dio.options.headers = headers;
      } else {
        dio.options.headers = {
          // "Authorization": preferenceManager.authToken(),
          // "lang": preferenceManager.currentLang(),
        };
        dio.options.baseUrl = ApiConfigurations().baseUrlProd;
      }
      response = await dio.get(url, queryParameters: body);
      print("***************GET $url , query: $body ***************");
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
      }
    }
    return handleResponse<ResponseType>(response, responseType, canLogOut, isDoorBird: isDoorBird);
  }

  Future<NetworkResponse<ResponseType>> post<ResponseType extends Mappable>(ResponseType responseType, String url,
      {var body, encoding, Map<String, String>? headers, bool isDoorBird = false, bool canLogOut = true}) async {
    var response;
    print("*************** POST $url , body: $body ***************");
    try {
      if (isDoorBird) {
        dio.options.baseUrl = "https://api.doorbird.io/";
        dio.options.headers = headers;
      } else {
        if (headers != null) {
          Map<String, dynamic> _headers = {
            // "Authorization": preferenceManager.authToken(),
            // "lang": preferenceManager.currentLang(),
          };
          _headers.addAll(headers);
          dio.options.headers = _headers;
        } else {
          dio.options.headers = {
            // "Authorization": preferenceManager.authToken(),
            // "lang": preferenceManager.currentLang(),
          };
        }
        print("Headers ${dio.options.headers}");
        dio.options.baseUrl = ApiConfigurations().baseUrlProd;
      }
      response = await dio.post(url, data: body, options: Options(requestEncoder: encoding));
    } on DioError catch (e) {
      print("MESSAGE ERROR ${e.message}");
      print("MESSAGE ERROR ${e.error}");
      if (e.response != null) {
        response = e.response;
      }
    }
    return handleResponse<ResponseType>(response, responseType, canLogOut, isDoorBird: isDoorBird);
  }

  Future<NetworkResponse<ResponseType>> put<ResponseType extends Mappable>(ResponseType responseType, String url,
      {var body, encoding, Map<String, String>? headers, bool canLogOut = true}) async {
    var response;
    print("*************** PUT $url , body: $body ***************  ");

    try {
      if (headers != null) {
        dio.options.headers = headers;
      } else {
        dio.options.headers = {
          // "Authorization": preferenceManager.authToken(),
          // "lang": preferenceManager.currentLang(),
        };
      }
      response = await dio.put(url, data: body, options: Options(requestEncoder: encoding));
    } on DioError catch (e) {
      //  print(e.toString());
      if (e.response != null) {
        response = e.response;
      }
    }
    return handleResponse<ResponseType>(response, responseType, canLogOut);
  }

  Future<NetworkResponse<ResponseType>> delete<ResponseType extends Mappable>(ResponseType responseType, String url,
      {var body, encoding, bool canLogOut = true}) async {
    var response;
    print("*************** Delete $url , body: $body ***************  ");

    try {
      dio.options.headers = {
        // "Authorization": preferenceManager.authToken(),
        // "lang": preferenceManager.currentLang(),
      };
      response = await dio.delete(url, data: body, options: Options(requestEncoder: encoding));
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
      }
    }
    return handleResponse<ResponseType>(response, responseType, canLogOut);
  }

  NetworkResponse<ResponseType> handleResponse<ResponseType extends Mappable>(
      Response response, ResponseType responseType, bool canLogOut,
      {bool isDoorBird = false}) {
    log(response.data.toString());
    try {
      final int statusCode = response.statusCode!;
      print("Status_Code_is ::  $statusCode");
      if (statusCode != 200) {
        // log("RESPONSE   ${response.data}");
      }
      if (statusCode >= 200 && statusCode < 300) {
        // print("correrct request: " + response.toString());
        if (responseType is ListMappable) {
          return NetworkResponse<ResponseType>(Mappable(responseType, response.data) as ResponseType, true, "",
              statusCode: statusCode);
        } else {
          return NetworkResponse<ResponseType>(Mappable(responseType, response) as ResponseType, true, "",
              statusCode: statusCode);
        }
      } else if (statusCode == 401 && !isDoorBird) {
        // if (canLogOut) {
        //   Modular.get<LogOutBloc>().add(LogOut());
        //   Modular.to.navigate("${NavigatorKeys.AUTH_KEY}/");
        // }
        return NetworkResponse<ResponseType>(
            Mappable(responseType, response) as ResponseType, false, response.data['message'],
            statusCode: statusCode);
      } else if (statusCode == 404) {
        return NetworkResponse<ResponseType>(
            Mappable(responseType, response) as ResponseType, false, response.data['message'],
            statusCode: statusCode);
      } else {
        print("request error: " + response.toString());
        return NetworkResponse<ResponseType>(
            Mappable(responseType, response) as ResponseType, false, response.data['message'],
            // response.data['detail'] ?? response.data['error_description'] ?? response.data['message'],
            statusCode: statusCode);
      }
    } on DioError catch (e) {
      // print(e.toString());
      // if (e.response != null) {
      //   response = e.response;
      // }
      return NetworkResponse<ResponseType>(
          Mappable(responseType, response) as ResponseType, false, e.message ?? "something_went_wrong");
    } catch (e) {
      return NetworkResponse<ResponseType>(
          Mappable(responseType, response) as ResponseType, false, "something_went_wrong");
    }
  }
}
