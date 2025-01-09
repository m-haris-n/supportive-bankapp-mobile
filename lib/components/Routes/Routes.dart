import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:supportive_app/UI/ChangePasswordPage/ChangePasswordPage.dart';
import 'package:supportive_app/UI/EditProfilePage/EditProfilePage.dart';
import 'package:supportive_app/UI/ForgotPasswordPage/ForgotPassword.dart';
import 'package:supportive_app/UI/ResetPasswordCodePage/ResetPasswordCodePage.dart';
import '../../Constants/RouteConstants/RouteConstants.dart';
import '../../UI/AuthPages/LoginPage.dart';
import '../../UI/AuthPages/SignupPage/SignupPage.dart';
import '../../UI/ChatListPage/ChatListPage.dart';
import '../../UI/ChatScreen/ChatScreen.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    const animationDuration = Duration(microseconds: 300);

    final args = settings.arguments;

    switch (settings.name) {
      case RouteConstants.initialPageRoute:
        return PageTransition(
            child: const LoginPage(), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.signupPageRoute:
        return PageTransition(
            child: const SignupPage(), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.chatListPage:
        return PageTransition(
            child: const ChatListPage(), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.chatPage:
        return PageTransition(
            child: const ChatScreen(), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.changePasswordPage:
        return PageTransition(
            child: const ChangePasswordPage(), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.editProfilePage:
        return PageTransition(
            child: const EditProfilePage(), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.forgotPasswordPage:
        return PageTransition(
            child: const ForgotPasswordPage(), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.otpVerificationPage:
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
