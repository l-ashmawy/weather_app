class WindModel {
  double? speed;
  int? deg;

  WindModel({this.speed, this.deg});

  WindModel.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
    deg = json['deg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['speed'] = speed;
    data['deg'] = deg;
    return data;
  }
}
