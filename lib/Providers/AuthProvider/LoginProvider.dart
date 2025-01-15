import 'package:flutter/cupertino.dart';
import 'package:supportive_app/Models/AuthModel/LoginModel/LoginResponseModel.dart';

class LoginProvider extends ChangeNotifier{

  LoginResponseModel? loginResponse;

  setLoginResponse(LoginResponseModel data){
    loginResponse = data;
    notifyListeners();
  }
}