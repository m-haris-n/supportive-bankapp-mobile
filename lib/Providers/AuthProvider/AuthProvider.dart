import 'package:flutter/cupertino.dart';
import 'package:supportive_app/Models/AuthModel/LoginModel/LoginResponseModel.dart';
import 'package:supportive_app/Models/AuthModel/SignupModel/SignupResponseModel.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginResponseModel? loginResponse;
  SignupResponseModel? signupResponse;

  setLoginResponse(LoginResponseModel data){
    loginResponse = data;
    notifyListeners();
  }

  setSignupResponse(SignupResponseModel data) {
    signupResponse = data;
    notifyListeners();
  }
}