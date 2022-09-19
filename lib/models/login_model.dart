class LoginModel {
  bool? sucess;
  String? userStatus;
  String? msg;
  String? token;

  LoginModel({this.sucess, this.userStatus, this.msg, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    sucess = json['sucess'] ?? '';
    userStatus = json['user_status'] ?? '';
    msg = json['msg'] ?? '';
    token = json['token'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sucess'] = sucess;
    data['user_status'] = userStatus;
    data['msg'] = msg;
    data['token'] = token;
    return data;
  }
}
