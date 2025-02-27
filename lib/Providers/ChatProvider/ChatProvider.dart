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

  TextEditingController chatMessageController = TextEditingController();
  String? chatMessage;

  bool createNewChat = false;
  String? chatId;

  setCreateNewChatValue(bool value) {
    createNewChat = value;
    notifyListeners();
  }

  setChatId(String? chatIdValue) {
    chatId = chatIdValue;
    notifyListeners();
  }

  setAllChatResponseModel(GetAllChatResponseModel response) {
    getAllChatResponse = response;
    notifyListeners();
  }

  setChatByIdResponseModel(GetChatByIdResponseModel response) {
    getChatByIdResponse = response;
    notifyListeners();
  }

  setAddChatByIdResponse(ChatMessages chatMessage, String userId) {
    ChatMessages message = ChatMessages(
        id: "",
        chatId: chatMessage.chatId,
        message: chatMessage.message,
        senderId: chatMessage.senderId,
        createdAt: "${DateTime.now()}",
        deletedAt: "${DateTime.now()}",
        updatedAt: "${DateTime.now()}");
    if (getChatByIdResponse != null) {
      getChatByIdResponse?.data!.messages!.add(message);
    } else {
      getChatByIdResponse = GetChatByIdResponseModel(
          success: true,
          status: 200,
          data: ChatDataById(id: message.chatId, userId: userId, messages: [message]));
    }
    notifyListeners();
  }

  setCreateChatResponseModel(CreateChatResponseModel response) {
    createChatResponse = response;
    notifyListeners();
  }

  setSendChatMessageResponse(SendChatMessageResponseModel response) {
    sendChatMessageResponse = response;
    if (sendChatMessageResponse != null &&
        sendChatMessageResponse?.success == true &&
        (sendChatMessageResponse!.status == 201 || sendChatMessageResponse!.status == 200)) {
      var chatMessage = sendChatMessageResponse!.data;
      setAddChatByIdResponse(
          ChatMessages(
              id: chatMessage!.id,
              chatId: chatMessage.chatId,
              message: chatMessage.message,
              senderId: chatMessage.senderId),
          "");
    }
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
    }

    notifyListeners();
  }

  pinAndUnPinChat(String? chatId, {bool isPinChat = false}) {
    if (isPinChat) {
      var chatData = getAllChatResponse!.data!.pinnedChats!.where((element) => element.id == chatId).first;
      getAllChatResponse!.data!.chats!.add(chatData);
      getAllChatResponse!.data!.pinnedChats!.removeWhere((element) => element.id == chatId);
    } else {
      var chatData = getAllChatResponse!.data!.chats!.where((element) => element.id == chatId).first;
      getAllChatResponse!.data!.pinnedChats!.add(chatData);
      getAllChatResponse!.data!.chats!.removeWhere((element) => element.id == chatId);
    }

    notifyListeners();
  }

  cleanChatBox() {
    chatMessageController.clear();
    notifyListeners();
  }

  reset() {
    chatId = null;
    createNewChat = false;
    getChatByIdResponse = null;
    chatMessageController.clear();
    chatMessage = null;

    notifyListeners();
  }

  List<String> settingPopUp = ["Edit Profile", "Change Password", "Log Out"];
}
