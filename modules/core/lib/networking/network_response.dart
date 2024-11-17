import 'network_mappers.dart';

class NetworkResponse<T> {
  final T body;

  final bool isRequestSuccess;
  final String errorMessage;
  final int? statusCode;

  NetworkResponse(this.body, this.isRequestSuccess, this.errorMessage, {this.statusCode});
}

class BoolResponse extends BoolMappable {
  bool? resBool;

  BoolResponse({this.resBool});
}
