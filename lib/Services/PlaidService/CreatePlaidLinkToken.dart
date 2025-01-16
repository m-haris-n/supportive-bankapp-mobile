import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Models/PlaidModel/PlaidLinkResponseModel.dart';
import 'package:supportive_app/Providers/AuthProvider/AuthProvider.dart';
import 'package:supportive_app/Providers/PlaidProvider/PlaidProvider.dart';
import 'package:supportive_app/Services/Api/ApiCallExceptions.dart';
import 'package:supportive_app/Services/Api/ApiCallFunctions.dart';
import 'package:supportive_app/Services/Api/ApiCallResponse.dart';
import 'package:supportive_app/Services/SharePreferencesService/SharePreferenceService.dart';
import 'package:supportive_app/Utils/Constant/ApiUrl.dart';
import 'package:supportive_app/Utils/Constant/KeysConstant.dart';

class CreatePlaidLinkTokenService {
  Future<ApiCallResponse<PlaidLinkResponseModel>> callCreatePlaidLinkTokenService(
      BuildContext context) async {
    try {
      var userId = await SharedPreferencesService().getString(KeysConstant.userId);
      var plaidProvider = Provider.of<PlaidProvider>(context, listen: false);
      var response = await Api().getRequest(context, ApiUrl.plaidLinkToken + "?id=$userId", sendToken: true);
      debugPrint("PlaidLinkResponse: $response");
      PlaidLinkResponseModel responseModel = PlaidLinkResponseModel.fromJson(response);
      debugPrint("PlaidLinkResponseModel: ${responseModel.toJson()}");
      plaidProvider.setPlaidLinkResponse(responseModel);
      return ApiCallResponse.completed(responseModel);
    } on BadRequestException {
      return ApiCallResponse.error('Bad Request Exception');
    } on UnauthorisedException {
      return ApiCallResponse.error('The User is Un-authorized');
    } on RequestNotFoundException {
      return ApiCallResponse.error('Request Not Found');
    } on UnAuthorizationException {
      return ApiCallResponse.error('The User is Un-authorized');
    } on InternalServerException {
      return ApiCallResponse.error('Internal Server Error');
    } on ServerNotFoundException {
      return ApiCallResponse.error('Server Not Available');
    } on FetchDataException {
      return ApiCallResponse.error('An Error occurred while Fetching the Data');
    } catch (e) {
      return ApiCallResponse.error(e.toString());
    }
  }
}
