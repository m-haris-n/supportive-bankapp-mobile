import 'package:flutter/cupertino.dart';
import 'package:supportive_app/Models/AuthModel/ChangePasswordModel/ChangePasswordResponseModel.dart';
import 'package:supportive_app/Models/AuthModel/LoginModel/LoginResponseModel.dart';
import 'package:supportive_app/Models/AuthModel/ProfileModel/UpdateProfileResponseModel.dart';
import 'package:supportive_app/Models/AuthModel/ProfileModel/UserProfileResponseModel.dart';
import 'package:supportive_app/Models/AuthModel/SignupModel/SignupResponseModel.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  LoginResponseModel? loginResponse;
  SignupResponseModel? signupResponse;
  UserProfileResponseModel? userProfileResponse;
  UpdateProfileResponseModel? updateProfileResponse;
  ChangePasswordResponseModel? changePasswordResponse;

  setLoginResponse(LoginResponseModel data) {
    loginResponse = data;
    notifyListeners();
  }

  setSignupResponse(SignupResponseModel data) {
    signupResponse = data;
    notifyListeners();
  }

  setUserProfileResponse(UserProfileResponseModel data) {
    userProfileResponse = data;
    if (userProfileResponse != null && userProfileResponse!.data != null) {
      var userData = userProfileResponse!.data;
      firstNameController.text = userData!.firstName ?? "";
      lastNameController.text = userData.lastName ?? "";
      emailController.text = userData.email ?? "";
    }
    notifyListeners();
  }

  setChangePasswordResponse(ChangePasswordResponseModel data) {
    changePasswordResponse = data;
    notifyListeners();
  }

  setUpdateProfileResponse(UpdateProfileResponseModel data) {
    updateProfileResponse = data;
    notifyListeners();
  }

  reset() {
    oldPasswordController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    notifyListeners();
  }
}
