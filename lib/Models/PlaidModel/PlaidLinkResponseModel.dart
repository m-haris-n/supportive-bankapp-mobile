class PlaidLinkResponseModel {
  bool? success;
  Data? data;
  int? status;

  PlaidLinkResponseModel({this.success, this.data, this.status});

  PlaidLinkResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? expiration;
  String? linkToken;
  String? requestId;

  Data({this.expiration, this.linkToken, this.requestId});

  Data.fromJson(Map<String, dynamic> json) {
    expiration = json['expiration'];
    linkToken = json['link_token'];
    requestId = json['request_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expiration'] = this.expiration;
    data['link_token'] = this.linkToken;
    data['request_id'] = this.requestId;
    return data;
  }
}
