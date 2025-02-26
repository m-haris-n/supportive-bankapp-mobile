import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Models/ChatModel/GetChatModel/GetChatByIdResponseModel.dart';
import 'package:supportive_app/Models/ChatModel/SendChatModel/SendChatMessageRequestModel.dart';
import 'package:supportive_app/Models/ChatModel/SendChatModel/SendChatMessageResponseModel.dart';
import 'package:supportive_app/Providers/ChatProvider/ChatProvider.dart';
import 'package:supportive_app/Services/Api/ApiCallFunctions.dart';
import 'package:supportive_app/Services/Api/ApiCallResponse.dart';
import 'package:supportive_app/Services/SharePreferencesService/SharePreferenceService.dart';
import 'package:supportive_app/Utils/Constant/ApiUrl.dart';
import 'package:supportive_app/Utils/Constant/KeysConstant.dart';

class SendChatService {
  Future<ApiCallResponse<SendChatMessageResponseModel>?> callSendChatService(
      BuildContext context, String? chatId) async {
    var userId = await SharedPreferencesService().getString(KeysConstant.userId);
    var chatProvider = Provider.of<ChatProvider>(context, listen: false);

    try {
      SendChatMessageRequestModel requestModel = SendChatMessageRequestModel(
          senderId: userId, chatId: chatId, message: chatProvider.chatMessage.text);
      debugPrint("SendChatMessageRequestModel:${requestModel.toJson()}");
      var response =
          await Api().postRequest(context, ApiUrl.sendMessage, requestModel.toJson(), sendToken: true);
      debugPrint("SendChatMessageResponse:$response");
      SendChatMessageResponseModel responseModel = SendChatMessageResponseModel.fromJson(response);
      debugPrint("SendChatMessageResponseModel:${responseModel.toJson()}");

      chatProvider.setSendChatMessageResponse(responseModel);
      return ApiCallResponse.completed(responseModel);
    } catch (e) {
      debugPrint("LoginApiError:${e.toString()}");
      return ApiCallResponse.error(e.toString());
    }
  }
}
