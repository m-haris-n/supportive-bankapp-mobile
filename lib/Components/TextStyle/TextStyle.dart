import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supportive_app/Utils/Constant/ColorConstants.dart';

var poppinsBold = "PoppinsBold";
var poppinsMedium = "PoppinsMedium";
var poppinsRegular = "PoppinsRegular";
var poppinsLight = "PoppinsLight";

class AppTextStyle{

 static  var poppinsBoldStyle = TextStyle(
    color: ColorConstants.blackColor,
    fontWeight: FontWeight.w600,
    fontFamily: poppinsBold,
    fontSize: 24.sp,
  );
 static var poppinsLightStyle = TextStyle(
    color: ColorConstants.textGreyColor,
    fontWeight: FontWeight.normal,
    fontFamily: poppinsLight,
    fontSize: 14.sp,
  );
}