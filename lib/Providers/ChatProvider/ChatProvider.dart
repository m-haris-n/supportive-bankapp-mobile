import 'package:flutter/material.dart';
import 'package:supportive_app/Models/ChatModel/ChatPinModel/ChatPinResponseModel.dart';
import 'package:supportive_app/Models/ChatModel/ChatPinModel/ChatUnpinResponseModel.dart';
import 'package:supportive_app/Models/ChatModel/CreateChatModel/CreateChatResponseModel.dart';
import 'package:supportive_app/Models/ChatModel/DeleteChatModel/DeleteChatResponseModel.dart';
import 'package:supportive_app/Models/ChatModel/GetChatModel/GetAllChatResponseModel.dart';
import 'package:supportive_app/Models/ChatModel/GetChatModel/GetChatByIdResponseModel.dart';
import 'package:supportive_app/Models/ChatModel/SendChatModel/SendChatMessageResponseModel.dart';

class ChatProvider extends ChangeNotifier {
  GetAllChatResponseModel? getAllChatResponse;
  GetChatByIdResponseModel? getChatByIdResponse;
  CreateChatResponseModel? createChatResponse;
  SendChatMessageResponseModel? sendChatMessageResponse;
  DeleteChatResponseModel? deleteChatResponse;
  ChatPinResponseModel? chatPinResponse;
  ChatUnpinResponseModel? chatUnpinResponse;

  TextEditingController chatMessage = TextEditingController();

  setAllChatResponseModel(GetAllChatResponseModel response) {
    getAllChatResponse = response;
    notifyListeners();
  }

  setChatByIdResponseModel(GetChatByIdResponseModel response) {
    getChatByIdResponse = response;
    notifyListeners();
  }

  setCreateChatResponseModel(CreateChatResponseModel response) {
    createChatResponse = response;
    notifyListeners();
  }

  setSendChatMessageResponse(SendChatMessageResponseModel response) {
    sendChatMessageResponse = response;
    notifyListeners();
  }

  setDeleteChatResponseModel(DeleteChatResponseModel response) {
    deleteChatResponse = response;
    notifyListeners();
  }

  setChatPinResponseModel(ChatPinResponseModel response) {
    chatPinResponse = response;
    notifyListeners();
  }

  setChatUnpinResponseModel(ChatUnpinResponseModel response) {
    chatUnpinResponse = response;
    notifyListeners();
  }

  deleteChatFromResponse(BuildContext context, String? chatId, {bool isPinChat = false}) {
    if (isPinChat) {
      getAllChatResponse!.data!.pinnedChats!.removeWhere((element) => element.id == chatId);
    } else {
      getAllChatResponse!.data!.chats!.removeWhere((element) => element.id == chatId);
      Navigator.of(context).pop(false);
    }

    notifyListeners();
  }

  cleanChatBox() {
    chatMessage.clear();
    notifyListeners();
  }
}
