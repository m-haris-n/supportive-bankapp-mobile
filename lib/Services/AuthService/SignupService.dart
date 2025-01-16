import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Models/AuthModel/SignupModel/SignupRequestModel.dart';
import 'package:supportive_app/Models/AuthModel/SignupModel/SignupResponseModel.dart';
import 'package:supportive_app/Providers/AuthProvider/AuthProvider.dart';
import 'package:supportive_app/Services/Api/ApiCallFunctions.dart';
import 'package:supportive_app/Services/Api/ApiCallResponse.dart';
import 'package:supportive_app/Utils/Constant/ApiUrl.dart';

class SignupService {
  Future<ApiCallResponse<SignupResponseModel>?> callSignupService(BuildContext context) async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    SignupRequestModel requestModel = SignupRequestModel(
        firstName: authProvider.nameController.text,
        lastName: "",
        email: authProvider.emailController.text.trim(),
        password: authProvider.passwordController.text);
    debugPrint(jsonEncode(requestModel));
    try {
      var response = await Api().postRequest(context, ApiUrl.register, requestModel.toJson());
      debugPrint("SignupApiResponse:$response");
      SignupResponseModel responseModel = SignupResponseModel.fromJson(response);
      debugPrint("SignupApiModelResponse:${responseModel.toJson()}");
      authProvider.setSignupResponse(responseModel);
      return ApiCallResponse.completed(responseModel);
    } catch (e) {
      debugPrint("UserRegistrationApiError:${e}");
      return ApiCallResponse.error(e.toString());
    }
  }
}
