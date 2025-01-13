import 'package:flutter/material.dart';

import '../../Utils/Constants/ColorConstants/ColorConstants.dart';

class AppLoader {
  showAppLoader() {
    return Center(
      child: CircularProgressIndicator(
        color: ColorConstants.appPrimaryColor,
      ),
    );
  }
}
