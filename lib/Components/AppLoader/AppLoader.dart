import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supportive_app/Utils/Constant/ColorConstants.dart';

class AppLoader extends StatelessWidget {
  bool showScaffold;
  Color? loaderColor;
  double? loaderSize;

  AppLoader({this.showScaffold = false, this.loaderColor, this.loaderSize});

  @override
  Widget build(BuildContext context) {
    return showScaffold
        ? Scaffold(
            backgroundColor: ColorConstants.appPrimaryColor,
            body: Center(
                child: CupertinoActivityIndicator(
              radius: loaderSize ?? 18,
              color: loaderColor ?? ColorConstants.whiteColor,
            )))
        : Center(
            child: CupertinoActivityIndicator(
            radius: loaderSize ?? 18,
            color: loaderColor ?? ColorConstants.whiteColor,
          ));
  }
}
