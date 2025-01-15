import 'package:flutter/cupertino.dart';
import 'package:supportive_app/Models/UserLoginResponseModel.dart';

class UserLoginProvider extends ChangeNotifier{

  UserLoginResponseModel? userLoginResponseModel;

  setUserLogin(UserLoginResponseModel data){
    userLoginResponseModel = data;
    notifyListeners();
  }
}