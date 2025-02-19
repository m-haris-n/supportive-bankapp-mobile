class ChatPinRequestModel {
  String? chatId;
  String? userId;

  ChatPinRequestModel({this.chatId, this.userId});

  ChatPinRequestModel.fromJson(Map<String, dynamic> json) {
    chatId = json['chat_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chat_id'] = this.chatId;
    data['user_id'] = this.userId;
    return data;
  }
}
