import 'package:core/core.dart';

class GlobalResponse extends BaseMappable {
  String? message;
  bool? isSuccess;

  GlobalResponse({this.message, this.isSuccess});

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    message = json['message'];
    isSuccess = json['isSuccess'];

    return GlobalResponse(message: message, isSuccess: isSuccess);
  }
}
