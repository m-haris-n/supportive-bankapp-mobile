import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:supportive_app/UI/Auth/ChangePassword/ChangePassword.dart';
import 'package:supportive_app/UI/Auth/ForgotPassword/ForgotPassword.dart';
import 'package:supportive_app/UI/Auth/Login/LoginPage.dart';
import 'package:supportive_app/UI/Auth/PlaidAuth/PlaidAuth.dart';
import 'package:supportive_app/UI/Auth/ResetPasswordCode/ResetPasswordCode.dart';
import 'package:supportive_app/UI/Auth/Signup/SignupPage.dart';
import 'package:supportive_app/UI/Chat/AllChatList.dart';
import 'package:supportive_app/UI/Chat/ChatScreen.dart';
import 'package:supportive_app/UI/UserProfile/EditProfile.dart';
import 'package:supportive_app/Utils/Constant/RouteConstant.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    const animationDuration = Duration(microseconds: 300);

    final args = settings.arguments;

    switch (settings.name) {
      case RouteConstant.login:
        return PageTransition(
            child: const LoginPage(), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstant.signupPageRoute:
        return PageTransition(
            child: const SignupPage(), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstant.allChatListPage:
        return PageTransition(
            child: const AllChatListPage(), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstant.chatScreen:
        return PageTransition(
            child: ChatScreen(
              data: args,
            ),
            type: PageTransitionType.fade,
            duration: animationDuration);
      case RouteConstant.changePasswordPage:
        return PageTransition(
            child: const ChangePasswordPage(), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstant.editProfilePage:
        return PageTransition(
            child: const EditProfilePage(), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstant.forgotPasswordPage:
        return PageTransition(
            child: const ForgotPasswordPage(), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstant.plaidAuth:
        return PageTransition(
            child: const PlaidAuth(), type: PageTransitionType.fade, duration: animationDuration);

      case RouteConstant.otpVerificationPage:
        return PageTransition(
            child: const ResetPasswordCodePage(), type: PageTransitionType.fade, duration: animationDuration);

      default:
        return _errorRoute();
    }
    // If args is not of the correct type, return an error page.
    // You can also throw an exception while in development.
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('ERROR'),
      ),
    );
  });
}
