import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/API/api.dart';
import 'package:supportive_app/API/api_response.dart';
import 'package:supportive_app/ApisEndPoint/ApiEndPoints.dart';
import 'package:supportive_app/Models/UserRegistrationRequestModel/UserRegistrationRequestModel.dart';
import 'package:supportive_app/Models/UserRegistrationResponseModel/UserRegistrationResponseModel.dart';
import 'package:supportive_app/Providers/RegistrationProvider.dart';

class UserRegistrationController {
  Future<ApiResponse<UserRegistrationResponseModel>?> userRegistration(
      BuildContext context,
      String? firstName,
      lastName,
      email,
      password) async {
    var userRegistrationProvider =
        Provider.of<UserRegistrationProvider>(context, listen: false);
    UserRegistrationRequestModel requestModel = UserRegistrationRequestModel(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password);
    debugPrint(jsonEncode(requestModel));
    try {
      var response = await Api.postRequestData(
          ApiEndPoints.register, requestModel.toJson(), context);
      debugPrint("UserRegistrationApiResponse:$response");
      UserRegistrationResponseModel responseModel =
          UserRegistrationResponseModel.fromJson(jsonDecode(response));
      debugPrint("UserRegistrationApiModelResponse:${responseModel.toJson()}");
      userRegistrationProvider.setUserRegistration(responseModel);
      return ApiResponse.completed(responseModel);
    } catch (e) {
      debugPrint("UserRegistrationApiError:${e.toString()}");
      return ApiResponse.error(e.toString());
    }
  }
}
