import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supportive_app/Components/TextStyle/TextStyle.dart';
import 'package:supportive_app/Utils/Constant/ColorConstants.dart';

class CustomAppButton extends StatelessWidget {
  final String? title;
  Widget? textWidget;
  final double? width, height, btnRadius, fontSize, btnIconSize, borderWidth;
  final Color? textColor, btnIconColor, btnColor, borderColor;
  final VoidCallback? onPress;
  Widget? btnIcon;
  Widget? imageButtonIcon;
  BorderSide? borderSide;
  FontWeight? fontWeight;
  final bool? isTitleUpperCase;
  String? fontFamily;
  TextStyle? style;
  CustomAppButton({super.key,
    this.title,
    this.width,
    this.height,
    this.btnRadius,
    this.fontSize,
    this.btnIconSize,
    this.borderWidth,
    this.textColor,
    this.btnIconColor,
    this.btnColor,
    this.borderColor,
    this.onPress,
    this.btnIcon,
    this.imageButtonIcon,
    this.fontWeight,
    this.isTitleUpperCase=false,
    this.fontFamily,
    this.borderSide,
    this.style,
    this.textWidget
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(btnRadius??8.sp),
          ),
          side: borderSide,
          backgroundColor: btnColor?? ColorConstants.appPrimaryColor,
          minimumSize: Size(width?? double.infinity, height??45.h)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          btnIcon??SizedBox(),
         textWidget ==null? Text(
            title??"",
                  style: style ??
                      AppTextStyle().poppinsBoldStyle().copyWith(
                          fontSize: fontSize?? 14.sp,
              fontWeight: fontWeight?? FontWeight.w500,
              fontFamily: fontFamily??poppinsBold,
              color: textColor??ColorConstants.whiteColor
            ),
          ):textWidget!,
          SizedBox(
            width: btnIcon != null ? 30 : 0,
          ),
        ],
      ),

    );
  }
}
