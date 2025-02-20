import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Models/ChatModel/CreateChatModel/CreateChatRequestModel.dart';
import 'package:supportive_app/Models/ChatModel/CreateChatModel/CreateChatResponseModel.dart';
import 'package:supportive_app/Providers/ChatProvider/ChatProvider.dart';
import 'package:supportive_app/Services/Api/ApiCallFunctions.dart';
import 'package:supportive_app/Services/Api/ApiCallResponse.dart';
import 'package:supportive_app/Services/SharePreferencesService/SharePreferenceService.dart';
import 'package:supportive_app/Utils/Constant/ApiUrl.dart';
import 'package:supportive_app/Utils/Constant/KeysConstant.dart';

class CreateChatService {
  Future<ApiCallResponse<CreateChatResponseModel>?> callCreateChatService(
    BuildContext context,
  ) async {
    var userId = await SharedPreferencesService().getString(KeysConstant.userId);
    var chatProvider = Provider.of<ChatProvider>(context, listen: false);
    CreateChatRequestModel requestModel = CreateChatRequestModel(userId: userId);
    debugPrint("CreateChatRequestModel:${requestModel.toJson()}");
    try {
      var response =
          await Api().postRequest(context, ApiUrl.createChat, requestModel.toJson(), sendToken: true);
      debugPrint("CreateChatResponse:$response");
      CreateChatResponseModel responseModel = CreateChatResponseModel.fromJson(response);
      debugPrint("CreateChatResponseModel:${responseModel.toJson()}");
      chatProvider.setCreateChatResponseModel(responseModel);
      return ApiCallResponse.completed(responseModel);
    } catch (e) {
      debugPrint("LoginApiError:${e.toString()}");
      return ApiCallResponse.error(e.toString());
    }
  }
}
