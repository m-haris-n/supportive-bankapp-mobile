import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../Constants/AssetConstants/AssetConstants.dart';
import '../../Constants/ColorConstants/ColorConstants.dart';
import '../../components/CustomAppButton/CustomAppButton.dart';
import '../../components/CustomBackground/CustomBackground.dart';
import '../../components/CustomOutlineTextField/CustomOutlineTextField.dart';
import '../../components/TextStyle/TextStyle.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        child: CustomBackground(
          padding: EdgeInsets.all(30.sp),
          widget: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Sign up",style: AppTextStyle.poppinsBoldStyle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Access to your\naccount",style: AppTextStyle.poppinsLightStyle,),
                        Image.asset(AssetConstants.botImage,height: 100.h,),
                      ],
                    ),
                    CustomOutlineTextFormField(
                      hintText: "Name",
                      filled: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset(AssetConstants.userIcon,),
                      ),
                      filledColor: ColorConstants.whiteColor,
                      borderSideColor: ColorConstants.whiteColor,

                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical:10.h),
                      child: CustomOutlineTextFormField(
                        hintText: "Phone/Email",
                        filled: true,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SvgPicture.asset(AssetConstants.userIcon,),
                        ),
                        filledColor: ColorConstants.whiteColor,
                        borderSideColor: ColorConstants.whiteColor,

                      ),
                    ),
                    CustomOutlineTextFormField(
                      hintText: "Password",
                      filled: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset(AssetConstants.lockIcon,),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset(AssetConstants.passwordEyeIcon),
                      ),
                      filledColor: ColorConstants.whiteColor,
                      borderSideColor: ColorConstants.whiteColor,

                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical:20.h),
                      child: CustomAppButton(
                        title: "Sign in",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        onPress: (){},
                      ),
                    ),
                    // Padding(
                    //   padding:  EdgeInsets.symmetric(vertical: 20.h),
                    //   child: Center(child: Text("Or Sign up with",style: AppTextStyle.poppinsLightStyle,)),
                    // ),
                    // CustomAppButton(
                    //   title: "Plaid",
                    //   fontSize: 14.sp,
                    //   fontWeight: FontWeight.w500,
                    //   btnColor: ColorConstants.whiteColor,
                    //   textColor: ColorConstants.blackColor,
                    //   btnIcon: Image.asset(AssetConstants.plaidImage,height: 20.h,),
                    //   onPress: (){},
                    // ),


                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                    text: "Not have an account?",
                    style: AppTextStyle.poppinsLightStyle,
                    children: [
                      TextSpan(
                          text: "Sign up",
                          style: AppTextStyle.poppinsLightStyle.copyWith(color: ColorConstants.appPrimaryColor)
                      )
                    ]
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
