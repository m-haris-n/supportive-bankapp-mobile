import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Models/AuthModel/ChangePasswordModel/ChangePasswordRequestModel.dart';
import 'package:supportive_app/Models/AuthModel/ChangePasswordModel/ChangePasswordResponseModel.dart';
import 'package:supportive_app/Providers/AuthProvider/AuthProvider.dart';
import 'package:supportive_app/Services/Api/ApiCallFunctions.dart';
import 'package:supportive_app/Services/Api/ApiCallResponse.dart';
import 'package:supportive_app/Services/SharePreferencesService/SharePreferenceService.dart';
import 'package:supportive_app/Utils/Constant/ApiUrl.dart';
import 'package:supportive_app/Utils/Constant/KeysConstant.dart';

class ChangePasswordService {
  Future<ApiCallResponse<ChangePasswordResponseModel>?> callChangePasswordService(
      BuildContext context) async {
    var userId = await SharedPreferencesService().getString(KeysConstant.userId);

    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    ChangePasswordRequestModel requestModel = ChangePasswordRequestModel(
        id: userId,
        oldPassword: authProvider.oldPasswordController.text,
        newPassword: authProvider.confirmPasswordController.text);
    try {
      var response =
          await Api().putRequest(context, ApiUrl.changePassword, requestModel.toJson(), sendToken: true);
      debugPrint("ChangePasswordResponse:$response");
      ChangePasswordResponseModel responseModel = ChangePasswordResponseModel.fromJson(response);
      debugPrint("ChangePasswordResponseModel:${responseModel.toJson()}");
      authProvider.setChangePasswordResponse(responseModel);
      return ApiCallResponse.completed(responseModel);
    } catch (e) {
      debugPrint("LoginApiError:${e.toString()}");
      return ApiCallResponse.error(e.toString());
    }
  }
}
