class GetChatByIdResponseModel {
  bool? success;
  ChatDataById? data;
  int? status;
  String? error;

  GetChatByIdResponseModel({this.success, this.data, this.status});

  GetChatByIdResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new ChatDataById.fromJson(json['data']) : null;
    status = json['status'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class ChatDataById {
  String? id;
  String? userId;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  List<ChatMessages>? messages;

  ChatDataById({this.id, this.userId, this.deletedAt, this.createdAt, this.updatedAt, this.messages});

  ChatDataById.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    deletedAt = json['deletedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['messages'] != null) {
      messages = <ChatMessages>[];
      json['messages'].forEach((v) {
        messages!.add(new ChatMessages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['deletedAt'] = this.deletedAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatMessages {
  String? id;
  String? chatId;
  dynamic senderId;
  String? message;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;

  ChatMessages(
      {this.id, this.chatId, this.senderId, this.message, this.deletedAt, this.createdAt, this.updatedAt});

  ChatMessages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chatId = json['chat_id'];
    senderId = json['sender_id'];
    message = json['message'];
    deletedAt = json['deletedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chat_id'] = this.chatId;
    data['sender_id'] = this.senderId;
    data['message'] = this.message;
    data['deletedAt'] = this.deletedAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
