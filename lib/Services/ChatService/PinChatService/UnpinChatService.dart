import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Models/ChatModel/ChatPinModel/ChatUnpinRequestModel.dart';
import 'package:supportive_app/Models/ChatModel/ChatPinModel/ChatUnpinResponseModel.dart';
import 'package:supportive_app/Providers/ChatProvider/ChatProvider.dart';
import 'package:supportive_app/Services/Api/ApiCallFunctions.dart';
import 'package:supportive_app/Services/Api/ApiCallResponse.dart';
import 'package:supportive_app/Services/SharePreferencesService/SharePreferenceService.dart';
import 'package:supportive_app/Utils/Constant/ApiUrl.dart';
import 'package:supportive_app/Utils/Constant/KeysConstant.dart';

class UnpinChatService {
  Future<ApiCallResponse<ChatUnpinResponseModel>?> callUnpinChatService(
      BuildContext context, String? chatId) async {
    var userId = await SharedPreferencesService().getString(KeysConstant.userId);
    var chatProvider = Provider.of<ChatProvider>(context, listen: false);
    ChatUnpinRequestModel requestModel = ChatUnpinRequestModel(chatId: chatId);
    debugPrint("DeleteChatRequestModel:${requestModel.toJson()}");
    try {
      var response = await Api().deleteRequest(context, ApiUrl.unpinChat, requestModel.toJson());
      debugPrint("ChatUnpinResponse:$response");
      ChatUnpinResponseModel responseModel = ChatUnpinResponseModel.fromJson(response);
      debugPrint("ChatUnpinResponseModel:${responseModel.toJson()}");
      chatProvider.setChatUnpinResponseModel(responseModel);
      return ApiCallResponse.completed(responseModel);
    } catch (e) {
      debugPrint("LoginApiError:${e.toString()}");
      return ApiCallResponse.error(e.toString());
    }
  }
}
