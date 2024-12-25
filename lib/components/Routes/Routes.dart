import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:supportive_app/AuthPages/LoginPage.dart';
import 'package:supportive_app/ChatListPage/ChatListPage.dart';

import '../../AuthPages/SignupPage/SignupPage.dart';
import '../../Constants/RouteConstants/RouteConstants.dart';


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
