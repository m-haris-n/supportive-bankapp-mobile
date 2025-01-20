import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Models/PlaidModel/PlaidAccessTokenResponseModel.dart';
import 'package:supportive_app/Providers/PlaidProvider/PlaidProvider.dart';
import 'package:supportive_app/Services/Api/ApiCallFunctions.dart';
import 'package:supportive_app/Services/Api/ApiCallResponse.dart';
import 'package:supportive_app/Utils/Constant/ApiUrl.dart';

class GetPlaidAccessTokenService {
  Future<ApiCallResponse<PlaidAccessTokenResponseModel>?> callGetPlaidAccessTokenService(BuildContext context,
      {String? publicToken}) async {
    var plaidProvider = Provider.of<PlaidProvider>(context, listen: false);
    var requestModel = {"public_token": "$publicToken"};

    try {
      var response = await Api().postRequest(context, ApiUrl.plaidAccessToken, requestModel);
      debugPrint("GetPlaidAccessTokenResponse:$response");
      PlaidAccessTokenResponseModel responseModel = PlaidAccessTokenResponseModel.fromJson(response);
      debugPrint("GetPlaidAccessTokenResponseModel:${responseModel.toJson()}");
      plaidProvider.setPlaidTokenResponse(responseModel);
      return ApiCallResponse.completed(responseModel);
    } catch (e) {
      debugPrint("LoginApiError:${e.toString()}");
      return ApiCallResponse.error(e.toString());
    }
  }
}
