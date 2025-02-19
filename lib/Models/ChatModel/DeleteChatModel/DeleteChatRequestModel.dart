class DeleteChatRequestModel {
  String? chatId;

  DeleteChatRequestModel({this.chatId});

  DeleteChatRequestModel.fromJson(Map<String, dynamic> json) {
    chatId = json['chat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chat_id'] = this.chatId;
    return data;
  }
}
