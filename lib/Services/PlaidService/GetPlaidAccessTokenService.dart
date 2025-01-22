import 'package:flutter/cupertino.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Models/PlaidModel/PlaidAccessTokenRequestModel.dart';
import 'package:supportive_app/Models/PlaidModel/PlaidAccessTokenResponseModel.dart';
import 'package:supportive_app/Providers/PlaidProvider/PlaidProvider.dart';
import 'package:supportive_app/Services/Api/ApiCallFunctions.dart';
import 'package:supportive_app/Services/Api/ApiCallResponse.dart';
import 'package:supportive_app/Services/SharePreferencesService/SharePreferenceService.dart';
import 'package:supportive_app/Utils/Constant/ApiUrl.dart';
import 'package:supportive_app/Utils/Constant/KeysConstant.dart';

class GetPlaidAccessTokenService {
  Future<ApiCallResponse<PlaidAccessTokenResponseModel>?> callGetPlaidAccessTokenService(BuildContext context,
      {String? publicToken, LinkInstitution? institution}) async {
    var userId = await SharedPreferencesService().getString(KeysConstant.userId);
    var plaidProvider = Provider.of<PlaidProvider>(context, listen: false);
    PlaidAccessTokenRequestModel requestModel = PlaidAccessTokenRequestModel(
        publicToken: "$publicToken", instituteId: institution!.id, userId: userId);
    debugPrint("GetPlaidAccessTokenRequestModel:${requestModel.toJson()}");
    try {
      var response = await Api().postRequest(context, ApiUrl.plaidAccessToken, requestModel.toJson());
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
