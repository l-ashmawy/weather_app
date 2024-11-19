class CloudsModel {
  int? all;

  CloudsModel({this.all});

  CloudsModel.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['all'] = all;
    return data;
  }
}
