import 'package:flutter/widgets.dart';
import 'package:supportive_app/Models/UserRegistrationResponseModel/UserRegistrationResponseModel.dart';

class UserRegistrationProvider extends ChangeNotifier {

  UserRegistrationResponseModel? userRegistrationResponseModel;

  setUserRegistration(UserRegistrationResponseModel data){
    userRegistrationResponseModel = data;
    notifyListeners();
  }
}