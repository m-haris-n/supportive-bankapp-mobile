class ChangePasswordRequestModel {
  String? id;
  String? oldPassword;
  String? newPassword;

  ChangePasswordRequestModel({this.id, this.oldPassword, this.newPassword});

  ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oldPassword = json['old_password'];
    newPassword = json['new_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['old_password'] = this.oldPassword;
    data['new_password'] = this.newPassword;
    return data;
  }
}
