class ErrorResponse {
  // Null? data;
  String? message;

  ErrorResponse({this.message});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    // data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['data'] = this.data;
    data['message'] = message;
    return data;
  }
}
