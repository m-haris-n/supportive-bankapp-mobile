import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Models/AuthModel/LoginModel/LoginRequestModel.dart';
import 'package:supportive_app/Models/AuthModel/LoginModel/LoginResponseModel.dart';
import 'package:supportive_app/Providers/AuthProvider/LoginProvider.dart';
import 'package:supportive_app/Services/Api/ApiCallFunctions.dart';
import 'package:supportive_app/Services/Api/ApiCallResponse.dart';
import 'package:supportive_app/Utils/Constant/ApiUrl.dart';


class LoginService{

  Future<ApiCallResponse<LoginResponseModel>?> callLoginService(BuildContext context,String? email,password)async{
    var userLoginProvider = Provider.of<LoginProvider>(context,listen: false);
    LoginRequestModel requestModel = LoginRequestModel(
      email: email,
       password: password
    );
    try{
      var response = await Api().postRequest(context,ApiUrl.login, requestModel.toJson());
      debugPrint("LoginApiResponse:$response");
      LoginResponseModel responseModel = LoginResponseModel.fromJson(jsonDecode(response));
      debugPrint("LoginApiModelResponse:${responseModel.toJson()}");
      userLoginProvider.setLoginResponse(responseModel);
      return ApiCallResponse.completed(responseModel);
    }catch (e){
      debugPrint("LoginApiError:${e.toString()}");
      return ApiCallResponse.error(e.toString());
    }
  }
}