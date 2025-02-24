import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Components/AppLoader/ShowLoaderLayer.dart';
import 'package:supportive_app/Components/CustomAppButton/CustomAppButton.dart';
import 'package:supportive_app/Components/CustomBackground/CustomBackground.dart';
import 'package:supportive_app/Components/CustomOutlineTextField/CustomOutlineTextField.dart';
import 'package:supportive_app/Components/ShowToast/ShowToast.dart';
import 'package:supportive_app/Components/TextStyle/TextStyle.dart';
import 'package:supportive_app/Providers/AuthProvider/AuthProvider.dart';
import 'package:supportive_app/Providers/LoadingProvider/LoadingProvider.dart';
import 'package:supportive_app/Services/AuthService/SignupService.dart';
import 'package:supportive_app/Utils/Constant/AssetImages.dart';
import 'package:supportive_app/Utils/Constant/ColorConstants.dart';
import 'package:supportive_app/Utils/Constant/RouteConstant.dart';
import 'package:supportive_app/Utils/HelperFunction.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<LoadingProvider, AuthProvider>(builder: (context, loadingProvider, authProvider, _) {
        return ShowLoaderLayer(
          startLoading: loadingProvider.isLoading,
          child: SingleChildScrollView(
            child: CustomBackground(
              padding: EdgeInsets.all(30.sp),
              widget: Column(
                children: [
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Sign up", style: AppTextStyle.poppinsBoldStyle),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Access to your\naccount",
                                style: AppTextStyle.poppinsLightStyle,
                              ),
                              Image.asset(
                                AssetsImages.botImage,
                                height: 100.h,
                              ),
                            ],
                          ),
                          CustomOutlineTextFormField(
                            hintText: "Name",
                            controller: authProvider.nameController,
                            validator: (value) => value!.isEmpty ? "Please enter your name" : null,
                            filled: true,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SvgPicture.asset(
                                AssetsImages.userIcon,
                              ),
                            ),
                            filledColor: ColorConstants.whiteColor,
                            borderSideColor: ColorConstants.whiteColor,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: CustomOutlineTextFormField(
                              hintText: "Phone/Email",
                              controller: authProvider.emailController,
                              validator: (value) =>
                                  EmailValidator.validate(value!) ? null : "Please enter your email/phone.",
                              filled: true,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: SvgPicture.asset(
                                  AssetsImages.phoneIcon,
                                ),
                              ),
                              filledColor: ColorConstants.whiteColor,
                              borderSideColor: ColorConstants.whiteColor,
                            ),
                          ),
                          CustomOutlineTextFormField(
                            hintText: "Password",
                            controller: authProvider.passwordController,
                            obscureText: authProvider.showPassword,
                            obscuringCharacter: "*",
                            validator: (value) {
                              return validatePassword(value ?? "");
                            },
                            filled: true,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SvgPicture.asset(
                                AssetsImages.lockIcon,
                              ),
                            ),
                            suffixIcon: InkWell(
                              onTap: () {
                                authProvider.setShowPasswordValue("password");
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: SvgPicture.asset(AssetsImages.passwordEyeIcon),
                              ),
                            ),
                            filledColor: ColorConstants.whiteColor,
                            borderSideColor: ColorConstants.whiteColor,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: CustomAppButton(
                              title: "Signup",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              onPress: () async {
                                if (_formKey.currentState!.validate()) {
                                  loadingProvider.setLoading(true);
                                  SignupService().callSignupService(context).then((response) {
                                    loadingProvider.setLoading(false);
                                    if (response!.responseData != null &&
                                        response.responseData?.success == true &&
                                        (response.responseData!.status == 201 ||
                                            response.responseData!.status == 200)) {
                                      ShowToast()
                                          .showFlushBar(context, message: "You are registered successfully!");
                                      Future.delayed(Duration(seconds: 2), () {
                                        Navigator.of(context).pushReplacementNamed(RouteConstant.login);
                                      });
                                    } else {
                                      ShowToast().showFlushBar(context,
                                          message:
                                              "${response.responseData != null ? response.responseData?.data!.first : "Please check your email it is not valid"}",
                                          error: true);
                                    }
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                        text: "Already have an account?",
                        style: AppTextStyle.poppinsLightStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pop();
                          },
                        children: [
                          TextSpan(
                            text: " Sign in",
                            style: AppTextStyle.poppinsLightStyle
                                .copyWith(color: ColorConstants.appPrimaryColor, fontSize: 16.sp),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pop();
                              },
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
