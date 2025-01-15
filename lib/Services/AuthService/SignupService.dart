import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Models/AuthModel/SignupModel/SignupRequestModel.dart';
import 'package:supportive_app/Models/AuthModel/SignupModel/SignupResponseModel.dart';
import 'package:supportive_app/Providers/AuthProvider/SignupProvider.dart';
import 'package:supportive_app/Services/Api/ApiCallFunctions.dart';
import 'package:supportive_app/Services/Api/ApiCallResponse.dart';
import 'package:supportive_app/Utils/Constant/ApiUrl.dart';

class SignupService {
  Future<ApiCallResponse<SignupResponseModel>?> callSignupService(
      BuildContext context,
      String? firstName,
      lastName,
      email,
      password) async {
    var userRegistrationProvider =
        Provider.of<SignupProvider>(context, listen: false);
    SignupRequestModel requestModel = SignupRequestModel(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password);
    debugPrint(jsonEncode(requestModel));
    try {
      var response = await Api().postRequest(context,
          ApiUrl.register, requestModel.toJson());
      debugPrint("SignupApiResponse:$response");
      SignupResponseModel responseModel =
          SignupResponseModel.fromJson(jsonDecode(response));
      debugPrint("SignupApiModelResponse:${responseModel.toJson()}");
      userRegistrationProvider.setSignupResponse(responseModel);
      return ApiCallResponse.completed(responseModel);
    } catch (e) {
      debugPrint("UserRegistrationApiError:${e.toString()}");
      return ApiCallResponse.error(e.toString());
    }
  }
}
