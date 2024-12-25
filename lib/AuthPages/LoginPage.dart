import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supportive_app/Constants/AssetConstants/AssetConstants.dart';
import 'package:supportive_app/Constants/ColorConstants/ColorConstants.dart';
import 'package:supportive_app/components/CustomAppButton/CustomAppButton.dart';
import 'package:supportive_app/components/CustomOutlineTextField/CustomOutlineTextField.dart';
import 'package:supportive_app/components/TextStyle/TextStyle.dart';
import '../Constants/RouteConstants/RouteConstants.dart';
import '../components/CustomBackground/CustomBackground.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: CustomBackground(
          padding: EdgeInsets.all(30.sp),
          widget: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Sign in",style: AppTextStyle.poppinsBoldStyle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Access to your\naccount",style: AppTextStyle.poppinsLightStyle,),
                        Image.asset(AssetConstants.botImage,height: 100.h,),
                      ],
                    ),
                    CustomOutlineTextFormField(
                      hintText: "Username",
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
                    ),
                    CustomAppButton(
                      title: "Sign in",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      onPress: (){
                        Navigator.of(context).pushNamedAndRemoveUntil(RouteConstants.chatListPage, (route)=>false);
                      },
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: 20.h),
                      child: Center(child: Text("Or Sign in with",style: AppTextStyle.poppinsLightStyle,)),
                    ),
                    CustomAppButton(
                      title: "Plaid",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      btnColor: ColorConstants.whiteColor,
                      textColor: ColorConstants.blackColor,
                      btnIcon: Image.asset(AssetConstants.plaidImage,height: 20.h,),
                      onPress: (){
                        Navigator.of(context).pushNamedAndRemoveUntil(RouteConstants.chatListPage, (route)=>false);

                      },
                    ),
          
          
                  ],
                ),
              ),
              Text.rich(

                TextSpan(
                    text: "Not have an account?",
                    style: AppTextStyle.poppinsLightStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pushNamed(
                            RouteConstants.signupPageRoute);
                      },
                    children: [
                      TextSpan(
                          text: "Sign up",
                          style: AppTextStyle.poppinsLightStyle.copyWith(color: ColorConstants.appPrimaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushNamed(
                                RouteConstants.signupPageRoute);
                          },
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
