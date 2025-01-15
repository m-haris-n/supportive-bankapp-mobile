import 'package:flutter/material.dart';
import 'package:supportive_app/Utils/Constant/ColorConstants.dart';

class AppLoader {
  showAppLoader() {
    return Center(
      child: CircularProgressIndicator(
        color: ColorConstants.appPrimaryColor,
      ),
    );
  }
}
