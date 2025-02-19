class SendChatMessageRequestModel {
  String? chatId;
  String? senderId;
  String? message;

  SendChatMessageRequestModel({this.chatId, this.senderId, this.message});

  SendChatMessageRequestModel.fromJson(Map<String, dynamic> json) {
    chatId = json['chat_id'];
    senderId = json['sender_id'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chat_id'] = this.chatId;
    data['sender_id'] = this.senderId;
    data['message'] = this.message;
    return data;
  }
}
