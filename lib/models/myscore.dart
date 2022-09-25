class MyScore {
  int? id;
  String? score;
  String? time;

  MyScore({
    this.id,
    this.score,
    this.time,
  });

  MyScore.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    score = json['score'] ?? "";
    time = json['time'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = score;
    data['score'] = score;
    data['time'] = time;
    return data;
  }
}
