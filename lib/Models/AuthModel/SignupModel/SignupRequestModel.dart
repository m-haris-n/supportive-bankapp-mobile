class SignupRequestModel {
  String? firstName;
  String? lastName;
  String? email;
  String? password;

  SignupRequestModel(
      {this.firstName, this.lastName, this.email, this.password});

  SignupRequestModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
