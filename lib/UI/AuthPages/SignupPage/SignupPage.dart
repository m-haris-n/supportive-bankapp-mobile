import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Controllers/UserRegistrationController.dart';
import 'package:supportive_app/Providers/LoadingProvider.dart';
import 'package:supportive_app/components/AppLoader/AppLoader.dart';
import 'package:supportive_app/components/ToastMessageWidget/ToastMessageWidget.dart';
import '../../../Constants/AssetConstants/AssetConstants.dart';
import '../../../Constants/ColorConstants/ColorConstants.dart';
import '../../../Constants/RouteConstants/RouteConstants.dart';
import '../../../components/CustomAppButton/CustomAppButton.dart';
import '../../../components/CustomBackground/CustomBackground.dart';
import '../../../components/CustomOutlineTextField/CustomOutlineTextField.dart';
import '../../../components/TextStyle/TextStyle.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoadingProvider>(
        builder: (context, loadingProvider,_) {
          return SingleChildScrollView(
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
                                AssetConstants.botImage,
                                height: 100.h,
                              ),
                            ],
                          ),
                          CustomOutlineTextFormField(
                            hintText: "Name",
                            controller: nameController,
                            validator: (value){
                              if(value!.isEmpty){
                                return "Please enter your name";
                              }
                            },
                            filled: true,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SvgPicture.asset(
                                AssetConstants.userIcon,
                              ),
                            ),
                            filledColor: ColorConstants.whiteColor,
                            borderSideColor: ColorConstants.whiteColor,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: CustomOutlineTextFormField(
                              hintText: "Phone/Email",
                              controller: emailController,
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Please enter your email/phone.";
                                }
                              },
                              filled: true,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: SvgPicture.asset(
                                  AssetConstants.phoneIcon,
                                ),
                              ),
                              filledColor: ColorConstants.whiteColor,
                              borderSideColor: ColorConstants.whiteColor,
                            ),
                          ),
                          CustomOutlineTextFormField(
                            hintText: "Password",
                            controller: passwordController,
                            obscureText: true,
                            obscuringCharacter: "*",
                            validator: (value){
                              if(value!.isEmpty){
                                return "Please enter your password.";
                              }
                            },
                            filled: true,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SvgPicture.asset(
                                AssetConstants.lockIcon,
                              ),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SvgPicture.asset(AssetConstants.passwordEyeIcon),
                            ),
                            filledColor: ColorConstants.whiteColor,
                            borderSideColor: ColorConstants.whiteColor,
                          ),
                        loadingProvider.isLoading?
                            AppLoader().showAppLoader():
                           Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: CustomAppButton(
                              title: "Signup",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              onPress: () async{
                                if(_formKey.currentState!.validate()){
                                  loadingProvider.setLoading(true);
                                 var response = await UserRegistrationController().userRegistration(context, nameController.text, "", emailController.text, passwordController.text);
                                 debugPrint("OnButtonApiResponse:$response}");
                                  loadingProvider.setLoading(false);

                                 if(response?.responseData?.success==true){
                                   ToastMessage().showToast(context, "You are registered successfully!", ColorConstants.appPrimaryColor);
                                   Navigator.of(context).pushNamed(RouteConstants.initialPageRoute);
                                 }
                                }
                              },
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
                  ),
                  Text.rich(
                    TextSpan(
                        text: "Already have an account?",
                        style: AppTextStyle.poppinsLightStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushNamed(
                                RouteConstants.initialPageRoute);
                          },
                        children: [
                          TextSpan(
                              text: "Sign in",
                              style: AppTextStyle.poppinsLightStyle
                                  .copyWith(color: ColorConstants.appPrimaryColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pushNamed(
                                    RouteConstants.initialPageRoute);
                              },
                          ),

                        ]),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
