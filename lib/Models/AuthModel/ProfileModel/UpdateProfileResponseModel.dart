class UpdateProfileResponseModel {
  bool? success;
  String? data;
  String? error;
  int? status;

  UpdateProfileResponseModel({this.success, this.data, this.error, this.status});

  UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    error = json['error'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['data'] = this.data;
    data['error'] = this.error;
    data['status'] = this.status;
    return data;
  }
}
