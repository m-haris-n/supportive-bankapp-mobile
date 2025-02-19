class GetAllChatResponseModel {
  bool? success;
  String? error;
  Data? data;
  int? status;

  GetAllChatResponseModel({this.success, this.error, this.data, this.status});

  GetAllChatResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
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

class Data {
  List<ChatData>? pinnedChats;
  List<ChatData>? chats;

  Data({this.pinnedChats, this.chats});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['pinnedChats'] != null) {
      pinnedChats = <ChatData>[];
      json['pinnedChats'].forEach((v) {
        pinnedChats!.add(new ChatData.fromJson(v));
      });
    }
    if (json['chats'] != null) {
      chats = <ChatData>[];
      json['chats'].forEach((v) {
        chats!.add(new ChatData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pinnedChats != null) {
      data['pinnedChats'] = this.pinnedChats!.map((v) => v.toJson()).toList();
    }
    if (this.chats != null) {
      data['chats'] = this.chats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatData {
  String? id;
  String? userId;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  List<Messages>? messages;

  ChatData({this.id, this.userId, this.deletedAt, this.createdAt, this.updatedAt, this.messages});

  ChatData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    deletedAt = json['deletedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
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

class Messages {
  String? id;
  String? chatId;
  dynamic senderId;
  String? message;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;

  Messages(
      {this.id, this.chatId, this.senderId, this.message, this.deletedAt, this.createdAt, this.updatedAt});

  Messages.fromJson(Map<String, dynamic> json) {
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
