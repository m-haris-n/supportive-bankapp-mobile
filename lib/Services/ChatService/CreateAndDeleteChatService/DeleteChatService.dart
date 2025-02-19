import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Models/ChatModel/DeleteChatModel/DeleteChatRequestModel.dart';
import 'package:supportive_app/Models/ChatModel/DeleteChatModel/DeleteChatResponseModel.dart';
import 'package:supportive_app/Providers/ChatProvider/ChatProvider.dart';
import 'package:supportive_app/Services/Api/ApiCallFunctions.dart';
import 'package:supportive_app/Services/Api/ApiCallResponse.dart';
import 'package:supportive_app/Services/SharePreferencesService/SharePreferenceService.dart';
import 'package:supportive_app/Utils/Constant/ApiUrl.dart';
import 'package:supportive_app/Utils/Constant/KeysConstant.dart';

class DeleteChatService {
  Future<ApiCallResponse<DeleteChatResponseModel>?> callDeleteChatService(
      BuildContext context, String? chatId) async {
    var userId = await SharedPreferencesService().getString(KeysConstant.userId);
    var chatProvider = Provider.of<ChatProvider>(context, listen: false);
    DeleteChatRequestModel requestModel = DeleteChatRequestModel(chatId: chatId);
    debugPrint("DeleteChatRequestModel:${requestModel.toJson()}");
    try {
      var response = await Api().deleteRequest(context, ApiUrl.deleteChat, requestModel.toJson());
      debugPrint("DeleteChatResponse:$response");
      DeleteChatResponseModel responseModel = DeleteChatResponseModel.fromJson(response);
      debugPrint("DeleteChatResponseModel:${responseModel.toJson()}");
      chatProvider.setDeleteChatResponseModel(responseModel);
      return ApiCallResponse.completed(responseModel);
    } catch (e) {
      debugPrint("LoginApiError:${e.toString()}");
      return ApiCallResponse.error(e.toString());
    }
  }
}
