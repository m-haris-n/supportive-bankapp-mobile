class ChatUnpinResponseModel {
  bool? success;
  String? data;
  int? status;

  ChatUnpinResponseModel({this.success, this.data, this.status});

  ChatUnpinResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['data'] = this.data;
    data['status'] = this.status;
    return data;
  }
}
