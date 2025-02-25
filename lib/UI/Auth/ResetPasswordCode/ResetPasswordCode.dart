import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:supportive_app/Components/TextStyle/TextStyle.dart';
import 'package:supportive_app/Utils/Constant/ColorConstants.dart';
import 'package:supportive_app/Components/CustomAppButton/CustomAppButton.dart';
import 'package:supportive_app/components/CustomBackground/CustomBackground.dart';

class ResetPasswordCodePage extends StatefulWidget {
  const ResetPasswordCodePage({super.key});

  @override
  State<ResetPasswordCodePage> createState() => _ResetPasswordCodePageState();
}

class _ResetPasswordCodePageState extends State<ResetPasswordCodePage> {
  final formKey = GlobalKey<FormState>();
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pinController.dispose();
    focusNode.dispose();
  }
  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = ColorConstants.appPrimaryColor;
    const fillColor = ColorConstants.whiteColor;
    const borderColor = ColorConstants.appPrimaryColor;

    final defaultPinTheme = PinTheme(
      width: 70.sp,
      height: 60.sp,
      textStyle: const TextStyle(
        fontSize: 22,
        color: ColorConstants.blackColor,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.sp),
        border: Border.all(color: borderColor),
      ),
    );
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
                  "Otp Verification",
                  style: AppTextStyle().poppinsBoldStyle(),
                ),
              ],
            ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 20.h),
              child: Text(
                "Enter the verification code we just sent on your email address.",
                style: AppTextStyle().poppinsLightStyle().copyWith(fontSize: 16.sp
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 90.h),
              child: Form(
                key: formKey,
                child: Directionality(
                  // Specify direction if desired
                  textDirection: TextDirection.ltr,
                  child: Center(
                    child: Pinput(
                      controller: pinController,
                      focusNode: focusNode,
                      // androidSmsAutofillMethod:
                      // AndroidSmsAutofillMethod.smsUserConsentApi,
                      // listenForMultipleSmsOnAndroid: true,
                      defaultPinTheme: defaultPinTheme,
                      // separatorBuilder: (index) => const SizedBox(width: 8),
                      validator: (value) {
                        if(value!.isEmpty){
                          return "please enter otp!";
                        }else{
                          return null;
                        }
                      },
                      // onClipboardFound: (value) {
                      //   debugPrint('onClipboardFound: $value');
                      //   pinController.setText(value);
                      // },
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      onCompleted: (pin) {
                        // setState(() {
                        //   widget.data["otp"] =pin;
                        // });
                        debugPrint('onCompleted: $pin');
                      },
                      onChanged: (value) {
                        debugPrint('onChanged: $value');
                      },
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 9),
                            width: 22,
                            height: 1,
                            color: focusedBorderColor,
                          ),
                        ],
                      ),

                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          border: Border.all(color: focusedBorderColor),
                          borderRadius: BorderRadius.circular(8.sp),

                        ),
                      ),
                      submittedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          color: fillColor,
                          border: Border.all(color: focusedBorderColor),
                          borderRadius: BorderRadius.circular(8.sp),

                        ),
                      ),
                      errorPinTheme: defaultPinTheme.copyBorderWith(
                        border: Border.all(color: Colors.redAccent),

                      ),
                    ),
                  ),
                ),
              ),
            ),
            CustomAppButton(
              title: "Verify",
              onPress: (){
                Navigator.of(context)..pop()..pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
