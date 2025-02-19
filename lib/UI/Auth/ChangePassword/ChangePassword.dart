import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Components/AppLoader/ShowLoaderLayer.dart';
import 'package:supportive_app/Components/ShowToast/ShowToast.dart';
import 'package:supportive_app/Providers/AuthProvider/AuthProvider.dart';
import 'package:supportive_app/Providers/LoadingProvider/LoadingProvider.dart';
import 'package:supportive_app/Services/AuthService/ChangePasswordService.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer2<LoadingProvider, AuthProvider>(builder: (context, loadingProvider, authProvider, _) {
      return Scaffold(
        body: ShowLoaderLayer(
          startLoading: loadingProvider.isLoading,
          child: CustomBackground(
            padding: EdgeInsets.only(top: 50.sp, left: 12.sp, right: 12.sp),
            widget: SingleChildScrollView(
              child: Form(
                key: _formKey,
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
                      controller: authProvider.oldPasswordController,
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
                      validator: (value) => value!.isNotEmpty ? null : "Please write old password",
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: CustomOutlineTextFormField(
                        hintText: "New Password",
                        controller: authProvider.passwordController,
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
                        validator: (value) => value!.isNotEmpty ? null : "Please write password",
                      ),
                    ),
                    CustomOutlineTextFormField(
                      hintText: "Re-Enter New Password",
                      controller: authProvider.confirmPasswordController,
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
                      validator: (value) => value!.isNotEmpty ? null : "Please write confirm password",
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomAppButton(
                      title: "Save",
                      onPress: () {
                        if (_formKey.currentState!.validate() &&
                            authProvider.passwordController.text ==
                                authProvider.confirmPasswordController.text) {
                          loadingProvider.setLoading(true);
                          loadingProvider.callUnFocus(context);
                          ChangePasswordService().callChangePasswordService(context).then((response) {
                            loadingProvider.setLoading(false);
                            if (response!.responseData != null &&
                                response.responseData?.success == true &&
                                (response.responseData!.status == 201 ||
                                    response.responseData!.status == 200)) {
                              ShowToast().showFlushBar(context, message: "Password change successfully");
                              authProvider.reset();
                              Future.delayed(Duration(seconds: 2), () {
                                Navigator.of(context).pop();
                              });
                            } else {
                              ShowToast().showFlushBar(context,
                                  message: response.responseData!.data!.password ??
                                      "Password not change successfully",
                                  error: true);
                            }
                          });
                        } else {
                          ShowToast().showFlushBar(context, message: "Password was not match", error: true);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
