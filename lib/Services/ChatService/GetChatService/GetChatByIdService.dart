import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Models/ChatModel/GetChatModel/GetChatByIdResponseModel.dart';
import 'package:supportive_app/Providers/ChatProvider/ChatProvider.dart';
import 'package:supportive_app/Providers/LoadingProvider/LoadingProvider.dart';
import 'package:supportive_app/Services/Api/ApiCallExceptions.dart';
import 'package:supportive_app/Services/Api/ApiCallFunctions.dart';
import 'package:supportive_app/Services/Api/ApiCallResponse.dart';
import 'package:supportive_app/Utils/Constant/ApiUrl.dart';

class GetChatByIdService {
  Future<ApiCallResponse<GetChatByIdResponseModel>> callGetChatByIdService(BuildContext context,
      {String? chatId}) async {
    try {
      var response =
          await Api().getRequest(context, ApiUrl.getChatById + "?chat_id=$chatId", sendToken: true);
      debugPrint("GetChatByIdResponse: $response");
      GetChatByIdResponseModel responseModel = GetChatByIdResponseModel.fromJson(response);
      debugPrint("GetChatByIdResponseModel: ${responseModel.toJson()}");
      Provider.of<ChatProvider>(context, listen: false).setChatByIdResponseModel(responseModel);
      Provider.of<LoadingProvider>(context, listen: false).setLoading(false);
      return ApiCallResponse.completed(responseModel);
    } on BadRequestException {
      Provider.of<LoadingProvider>(context, listen: false).setLoading(false);

      return ApiCallResponse.error('Bad Request Exception');
    } on UnauthorisedException {
      Provider.of<LoadingProvider>(context, listen: false).setLoading(false);

      return ApiCallResponse.error('The User is Un-authorized');
    } on RequestNotFoundException {
      Provider.of<LoadingProvider>(context, listen: false).setLoading(false);

      return ApiCallResponse.error('Request Not Found');
    } on UnAuthorizationException {
      Provider.of<LoadingProvider>(context, listen: false).setLoading(false);

      return ApiCallResponse.error('The User is Un-authorized');
    } on InternalServerException {
      Provider.of<LoadingProvider>(context, listen: false).setLoading(false);

      return ApiCallResponse.error('Internal Server Error');
    } on ServerNotFoundException {
      Provider.of<LoadingProvider>(context, listen: false).setLoading(false);

      return ApiCallResponse.error('Server Not Available');
    } on FetchDataException {
      Provider.of<LoadingProvider>(context, listen: false).setLoading(false);

      return ApiCallResponse.error('An Error occurred while Fetching the Data');
    } catch (e) {
      Provider.of<LoadingProvider>(context, listen: false).setLoading(false);

      return ApiCallResponse.error(e.toString());
    }
  }
}
