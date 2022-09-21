class InfoModel {
  String? mobile;
  String? name;

  InfoModel({this.mobile, this.name});

  InfoModel.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'] ?? "";
    name = json['name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = mobile;
    data['name'] = name;
    return data;
  }
}
