import 'package:flutter/material.dart';
import 'package:supportive_app/Models/ChatModel/ChatPinModel/ChatPinResponseModel.dart';
import 'package:supportive_app/Models/ChatModel/ChatPinModel/ChatUnpinResponseModel.dart';
import 'package:supportive_app/Models/ChatModel/CreateChatModel/CreateChatResponseModel.dart';
import 'package:supportive_app/Models/ChatModel/DeleteChatModel/DeleteChatResponseModel.dart';
import 'package:supportive_app/Models/ChatModel/GetChatModel/GetAllChatResponseModel.dart';
import 'package:supportive_app/Models/ChatModel/GetChatModel/GetChatByIdResponseModel.dart';

class ChatProvider extends ChangeNotifier {
  GetAllChatResponseModel? getAllChatResponse;
  GetChatByIdResponseModel? getChatByIdResponse;
  CreateChatResponseModel? createChatResponse;
  DeleteChatResponseModel? deleteChatResponse;
  ChatPinResponseModel? chatPinResponse;
  ChatUnpinResponseModel? chatUnpinResponse;

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
}
