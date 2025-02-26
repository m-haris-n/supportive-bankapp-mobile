import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Models/AuthModel/LoginModel/LoginRequestModel.dart';
import 'package:supportive_app/Models/AuthModel/LoginModel/LoginResponseModel.dart';
import 'package:supportive_app/Providers/AuthProvider/AuthProvider.dart';
import 'package:supportive_app/Services/Api/ApiCallFunctions.dart';
import 'package:supportive_app/Services/Api/ApiCallResponse.dart';
import 'package:supportive_app/Utils/Constant/ApiUrl.dart';


class LoginService{
  Future<ApiCallResponse<LoginResponseModel>?> callLoginService(BuildContext context) async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    LoginRequestModel requestModel = LoginRequestModel(
        email: authProvider.emailController.text.trim(), password: authProvider.passwordController.text);
    debugPrint("LoginRequestModel:${requestModel.toJson()}");
    try{
      var response = await Api().postRequest(context,ApiUrl.login, requestModel.toJson());
      debugPrint("LoginApiResponse:$response");
      LoginResponseModel responseModel = LoginResponseModel.fromJson(response);
      debugPrint("LoginApiModelResponse:${responseModel.toJson()}");
      authProvider.setLoginResponse(responseModel);
      return ApiCallResponse.completed(responseModel);
    }catch (e){
      debugPrint("LoginApiError:${e.toString()}");
      return ApiCallResponse.error(e.toString());
    }
  }
}