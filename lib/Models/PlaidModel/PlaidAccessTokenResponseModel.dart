class PlaidAccessTokenResponseModel {
  bool? success;
  Data? data;
  int? status;

  PlaidAccessTokenResponseModel({this.success, this.data, this.status});

  PlaidAccessTokenResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? accessToken;
  String? itemId;
  String? requestId;
  String? message;

  Data({this.accessToken, this.itemId, this.requestId, this.message});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    itemId = json['item_id'];
    requestId = json['request_id'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['item_id'] = this.itemId;
    data['request_id'] = this.requestId;
    data['message'] = this.message;
    return data;
  }
}
