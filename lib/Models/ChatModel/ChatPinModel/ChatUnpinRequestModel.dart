class ChatUnpinRequestModel {
  String? chatId;

  ChatUnpinRequestModel({this.chatId});

  ChatUnpinRequestModel.fromJson(Map<String, dynamic> json) {
    chatId = json['chat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chat_id'] = this.chatId;
    return data;
  }
}
