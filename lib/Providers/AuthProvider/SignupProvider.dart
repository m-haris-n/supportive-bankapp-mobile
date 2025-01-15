import 'package:flutter/widgets.dart';
import 'package:supportive_app/Models/AuthModel/SignupModel/SignupResponseModel.dart';

class SignupProvider extends ChangeNotifier {

  SignupResponseModel? signupResponse;

  setSignupResponse(SignupResponseModel data){
    signupResponse = data;
    notifyListeners();
  }
}