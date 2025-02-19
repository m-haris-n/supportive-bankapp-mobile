import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Components/AppLoader/ShowLoaderLayer.dart';
import 'package:supportive_app/Components/CustomBackground/CustomBackground.dart';
import 'package:supportive_app/Components/ShowToast/ShowToast.dart';
import 'package:supportive_app/Providers/AuthProvider/AuthProvider.dart';
import 'package:supportive_app/Providers/LoadingProvider/LoadingProvider.dart';
import 'package:supportive_app/Services/AuthService/LoginService.dart';
import 'package:supportive_app/Services/SharePreferencesService/SharePreferenceService.dart';
import 'package:supportive_app/Utils/Constant/AssetImages.dart';
import 'package:supportive_app/Utils/Constant/ColorConstants.dart';
import 'package:supportive_app/Utils/Constant/KeysConstant.dart';
import 'package:supportive_app/Utils/Constant/RouteConstant.dart';
import 'package:supportive_app/components/CustomAppButton/CustomAppButton.dart';
import 'package:supportive_app/components/CustomOutlineTextField/CustomOutlineTextField.dart';
import 'package:supportive_app/components/TextStyle/TextStyle.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool? isUserIdAvailable;
  bool? isPlaidTokenAvailable;

  checkAppStatus() async {
    isUserIdAvailable = await SharedPreferencesService().checkKey(KeysConstant.userId);
    isPlaidTokenAvailable = await SharedPreferencesService().checkKey(KeysConstant.plaidAccessToken);
    if (isUserIdAvailable == true) {
      if (isPlaidTokenAvailable!) {
        Navigator.of(context).pushNamedAndRemoveUntil(RouteConstant.allChatListPage, (route) => false);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(RouteConstant.plaidAuth, (route) => false);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAppStatus();
  }

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
                          Text("Sign in", style: AppTextStyle.poppinsBoldStyle),
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
                            hintText: "Username",
                            controller: authProvider.emailController,
                            validator: (value) =>
                                EmailValidator.validate(value!) ? null : "Please enter your email/phone.",
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
                              hintText: "Password",
                              controller: authProvider.passwordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password field is empty.";
                                }
                              },
                              filled: true,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: SvgPicture.asset(
                                  AssetsImages.lockIcon,
                                ),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: SvgPicture.asset(AssetsImages.passwordEyeIcon),
                              ),
                              filledColor: ColorConstants.whiteColor,
                              borderSideColor: ColorConstants.whiteColor,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(RouteConstant.forgotPasswordPage);
                              },
                              child: Text(
                                "Forgot Password?",
                                style: AppTextStyle.poppinsLightStyle.copyWith(color: Colors.red),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          CustomAppButton(
                            title: "Sign in",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            onPress: () async {
                              if (_formKey.currentState!.validate()) {
                                loadingProvider.setLoading(true);
                                var response = await LoginService().callLoginService(context);
                                loadingProvider.setLoading(false);
                                if (response!.responseData != null &&
                                    response.responseData?.success == true &&
                                    (response.responseData!.status == 201 ||
                                        response.responseData!.status == 200)) {
                                  ShowToast().showFlushBar(context, message: "Login successful");
                                  SharedPreferencesService().setString(
                                      KeysConstant.accessToken, response.responseData!.data!.token);
                                  SharedPreferencesService()
                                      .setString(KeysConstant.userId, response.responseData!.data!.id);
                                  Future.delayed(Duration(seconds: 2), () {
                                    if (isPlaidTokenAvailable! &&
                                        response.responseData!.data != null &&
                                        response.responseData!.data!.isPlaidConnect == true) {
                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                          RouteConstant.allChatListPage, (route) => false);
                                    } else {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(RouteConstant.plaidAuth, (route) => false);
                                    }
                                  });
                                } else {
                                  ShowToast().showFlushBar(context,
                                      message:
                                          "${response.responseData != null ? response.responseData?.data?.email != null ? response.responseData?.data?.email : response.responseData?.data?.password : "Please check your email and password"}",
                                      error: true);
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                        text: "Not have an account?",
                        style: AppTextStyle.poppinsLightStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushNamed(RouteConstant.signupPageRoute);
                          },
                        children: [
                          TextSpan(
                            text: " Sign up",
                            style: AppTextStyle.poppinsLightStyle
                                .copyWith(color: ColorConstants.appPrimaryColor, fontSize: 16.sp),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pushNamed(RouteConstant.signupPageRoute);
                              },
                          )
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
