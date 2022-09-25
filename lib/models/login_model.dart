class CreateModel {
  bool? sucess;
  String? userStatus;

  String? msg;
  String? token;

  CreateModel({this.sucess, this.userStatus, this.msg, this.token});

  CreateModel.fromJson(Map<String, dynamic> json) {
    sucess = json['sucess'];
    userStatus = json['user_status'] ?? "";
    msg = json['message'] ?? "";
    token = json['token'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['sucess'] = sucess;
    data['user_status'] = userStatus;
    data['message'] = msg;
    data['token'] = token;

    return data;
  }
}

class errorlogin {
  bool? sucess;
  String? msg;

  errorlogin({this.sucess, this.msg});

  errorlogin.fromJson(Map<String, dynamic> json) {
    sucess = json['sucess'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sucess'] = this.sucess;
    data['msg'] = this.msg;
    return data;
  }
}

class NameMode {
  String? name;
  String? mobile;

  NameMode({this.name, this.mobile});

  NameMode.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    return data;
  }
}

class LoginMode {
  bool? success;
  String? msg;
  String? token;
  String? name;
  String? mobile;

  LoginMode({this.success, this.msg, this.token, this.name, this.mobile});

  LoginMode.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['message'];
    token = json['token'];
    name = json['name'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    data['msg'] = msg;
    data['token'] = token;
    data['name'] = name;
    data['mobile'] = mobile;
    return data;
  }
}
