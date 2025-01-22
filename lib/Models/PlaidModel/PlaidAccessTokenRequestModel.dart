class PlaidAccessTokenRequestModel {
  String? publicToken;
  String? instituteId;
  String? userId;

  PlaidAccessTokenRequestModel({this.publicToken, this.instituteId, this.userId});

  PlaidAccessTokenRequestModel.fromJson(Map<String, dynamic> json) {
    publicToken = json['public_token'];
    instituteId = json['institute_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['public_token'] = this.publicToken;
    data['institute_id'] = this.instituteId;
    data['user_id'] = this.userId;
    return data;
  }
}
