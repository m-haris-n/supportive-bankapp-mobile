import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supportive_app/Utils/Constant/AssetImages.dart';
import 'package:supportive_app/Utils/Constant/ColorConstants.dart';
import 'package:supportive_app/components/CustomAppButton/CustomAppButton.dart';
import 'package:supportive_app/components/CustomBackground/CustomBackground.dart';
import 'package:supportive_app/components/CustomOutlineTextField/CustomOutlineTextField.dart';
import 'package:supportive_app/components/TextStyle/TextStyle.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        padding: EdgeInsets.only(top: 50.sp, left: 12.sp, right: 12.sp),
        widget: SingleChildScrollView(
          child: Column(
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
                    "Change Password",
                    style: AppTextStyle.poppinsBoldStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              CustomOutlineTextFormField(
                hintText: "Old Password",
                filledColor: ColorConstants.whiteColor,
                filled: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(AssetsImages.changePasswordIcon),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(AssetsImages.passwordEyeIcon),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: CustomOutlineTextFormField(
                  hintText: "New Password",
                  filledColor: ColorConstants.whiteColor,
                  filled: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(AssetsImages.changePasswordIcon),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(AssetsImages.passwordEyeIcon),
                  ),
                ),
              ),
              CustomOutlineTextFormField(
                hintText: "Re-Enter New Password",
                filledColor: ColorConstants.whiteColor,
                filled: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(AssetsImages.changePasswordIcon),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(AssetsImages.passwordEyeIcon),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              CustomAppButton(
                title: "Save",
                onPress: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
