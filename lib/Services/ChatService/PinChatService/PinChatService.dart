import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Models/ChatModel/ChatPinModel/ChatPinRequestModel.dart';
import 'package:supportive_app/Models/ChatModel/ChatPinModel/ChatPinResponseModel.dart';
import 'package:supportive_app/Providers/ChatProvider/ChatProvider.dart';
import 'package:supportive_app/Services/Api/ApiCallFunctions.dart';
import 'package:supportive_app/Services/Api/ApiCallResponse.dart';
import 'package:supportive_app/Services/SharePreferencesService/SharePreferenceService.dart';
import 'package:supportive_app/Utils/Constant/ApiUrl.dart';
import 'package:supportive_app/Utils/Constant/KeysConstant.dart';

class PinChatService {
  Future<ApiCallResponse<ChatPinResponseModel>?> callPinChatService(
      BuildContext context, String? chatId) async {
    var userId = await SharedPreferencesService().getString(KeysConstant.userId);
    var chatProvider = Provider.of<ChatProvider>(context, listen: false);
    ChatPinRequestModel requestModel = ChatPinRequestModel(userId: userId, chatId: chatId);
    debugPrint("CreateChatRequestModel:${requestModel.toJson()}");
    try {
      var response = await Api().postRequest(context, ApiUrl.pinChat, requestModel.toJson());
      debugPrint("ChatPinResponse:$response");
      ChatPinResponseModel responseModel = ChatPinResponseModel.fromJson(response);
      debugPrint("ChatPinResponseModel:${responseModel.toJson()}");
      chatProvider.setChatPinResponseModel(responseModel);
      return ApiCallResponse.completed(responseModel);
    } catch (e) {
      debugPrint("LoginApiError:${e.toString()}");
      return ApiCallResponse.error(e.toString());
    }
  }
}
