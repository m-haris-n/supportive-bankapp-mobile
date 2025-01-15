import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supportive_app/Components/TextStyle/TextStyle.dart';
import 'package:supportive_app/Utils/Constant/ColorConstants.dart';
import 'package:supportive_app/Utils/Constant/RouteConstant.dart';
import 'package:supportive_app/components/CustomAppButton/CustomAppButton.dart';
import 'package:supportive_app/components/CustomBackground/CustomBackground.dart';
import 'package:supportive_app/components/CustomOutlineTextField/CustomOutlineTextField.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        padding: EdgeInsets.only(top:50.sp,left: 12.sp,right: 12.sp),
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 20.w,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 25.sp,
                    )),
                Text(
                  "Forgot Password",
                  style: AppTextStyle.poppinsBoldStyle,
                ),
              ],
            ),
            SizedBox(
              height: 50.h,
            ),
            Text("Enter your email and we sent you a link on your email to reset your password.",style: AppTextStyle.poppinsLightStyle,),

            Padding(
              padding:  EdgeInsets.symmetric(vertical: 50.h),
              child: CustomOutlineTextFormField(
                hintText: "Enter your email",
                filled: true,
                filledColor: ColorConstants.whiteColor,
              ),
            ),
            CustomAppButton(
              title: "Continue",
              onPress: (){
                Navigator.of(context).pushNamed(RouteConstant.otpVerificationPage);
              },
            )
          ],
        ),
      ),
    );
  }
}
