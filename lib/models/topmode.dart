class TopModel {
  String? name;
  int? score;

  TopModel({this.name, this.score});

  TopModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['score'] = score;
    return data;
  }
}
