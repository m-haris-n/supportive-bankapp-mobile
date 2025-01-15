
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supportive_app/Utils/Constant/AppIcons.dart';
import 'package:supportive_app/Utils/Constant/ColorConstants.dart';

class ShowToast {
  showToast(BuildContext context, String? message, {bool error = false, Color? backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message ?? ""),
      backgroundColor: error ? ColorConstants.redColor : backgroundColor,
    ));
  }

  showFlushBar(BuildContext context,
      {required String message,
      bool error = false,
      bool showUndo = false,
      bool showMainButton = true,
      int durationSecond = 3,
      FlushbarPosition? flushbarPosition}) {
    return Flushbar(
      shouldIconPulse: false,
      message: message,
      duration: Duration(seconds: durationSecond),
      animationDuration: Duration(milliseconds: 500),
      isDismissible: true,
      messageColor: ColorConstants.blackColor,
      backgroundColor: ColorConstants.whiteColor,
      mainButton: showMainButton
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.sp),
              child: IntrinsicHeight(
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(
                    AppIcons.close,
                    size: 20.sp,
                    color: error ? ColorConstants.redColor : ColorConstants.greenColor,
                  ),
                ),
              ),
            )
          : SizedBox(),
      flushbarPosition: flushbarPosition ?? FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(8.sp),
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.all(15.sp),
      leftBarIndicatorColor: error ? ColorConstants.redColor : ColorConstants.greenColor,
    ).show(context);
  }
}
