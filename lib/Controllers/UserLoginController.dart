import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/API/api_response.dart';
import 'package:supportive_app/ApisEndPoint/ApiEndPoints.dart';
import 'package:supportive_app/Models/UserLoginRequestModel.dart';
import 'package:supportive_app/Models/UserLoginResponseModel.dart';
import 'package:supportive_app/Providers/UserLoginProvider.dart';

import '../API/api.dart';

class UserLoginController{

  Future<ApiResponse<UserLoginResponseModel>?> getLogin(BuildContext context,String? email,password)async{
    var userLoginProvider = Provider.of<UserLoginProvider>(context,listen: false);
    UserLoginRequestModel requestModel = UserLoginRequestModel(
      email: email,
       password: password
    );
    try{
      var response = await Api.postRequestData(ApiEndPoints.login, requestModel, context);
      debugPrint("UserLoginApiResponse:$response");
      UserLoginResponseModel responseModel = UserLoginResponseModel.fromJson(jsonDecode(response));
      debugPrint("UserLoginApiModelResponse:${responseModel.toJson()}");
      userLoginProvider.setUserLogin(responseModel);
      return ApiResponse.completed(responseModel);
    }catch (e){
      debugPrint("UserLoginApiError:${e.toString()}");
      return ApiResponse.error(e.toString());
    }
  }
}