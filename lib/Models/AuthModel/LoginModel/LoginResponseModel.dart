class LoginResponseModel {
  bool? success;
  Data? data;
  int? status;

  LoginResponseModel({this.success, this.data, this.status});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String? id;
  String? token;
  String? type;
  String? expiresIn;
  String? email;
  String? password;

  Data({this.id, this.token, this.type, this.expiresIn, this.email, this.password});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    type = json['type'];
    expiresIn = json['expires_in'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['token'] = this.token;
    data['type'] = this.type;
    data['expires_in'] = this.expiresIn;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
