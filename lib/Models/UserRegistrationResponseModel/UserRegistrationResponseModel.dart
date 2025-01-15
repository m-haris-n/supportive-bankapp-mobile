
class UserRegistrationResponseModel {
  bool? success;
  dynamic data;

  UserRegistrationResponseModel({this.success, this.data});

  UserRegistrationResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['data'] = this.data;
    return data;
  }
}
