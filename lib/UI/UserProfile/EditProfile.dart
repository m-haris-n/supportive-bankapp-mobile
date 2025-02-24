import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Components/AppLoader/ShowLoaderLayer.dart';
import 'package:supportive_app/Components/CustomAppButton/CustomAppButton.dart';
import 'package:supportive_app/Components/CustomOutlineTextField/CustomOutlineTextField.dart';
import 'package:supportive_app/Components/ShowToast/ShowToast.dart';
import 'package:supportive_app/Components/TextStyle/TextStyle.dart';
import 'package:supportive_app/Providers/AuthProvider/AuthProvider.dart';
import 'package:supportive_app/Providers/LoadingProvider/LoadingProvider.dart';
import 'package:supportive_app/Services/AuthService/UpdateProfileService.dart';
import 'package:supportive_app/Utils/Constant/AssetImages.dart';
import 'package:supportive_app/Utils/Constant/ColorConstants.dart';
import 'package:supportive_app/components/CustomBackground/CustomBackground.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<LoadingProvider, AuthProvider>(builder: (context, loadingProvider, authProvider, _) {
      return Scaffold(
        body: ShowLoaderLayer(
          startLoading: loadingProvider.isLoading,
          child: CustomBackground(
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
                        "Edit Profile",
                        style: AppTextStyle.poppinsBoldStyle,
                      ),
                    ],
                  ),
                  // Stack(
                  //   alignment: AlignmentDirectional.topStart,
                  //   children: [
                  //     Center(
                  //       child: Container(
                  //         height: 120.h,
                  //         width: 133.w,
                  //         decoration: const BoxDecoration(
                  //           shape: BoxShape.circle,
                  //         ),
                  //         child: ClipOval(
                  //           child: Image.network(
                  //             "https://images.unsplash.com/photo-1543610892-0b1f7e6d8ac1?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fHByb2ZpbGUlMjBpbWFnZXN8ZW58MHx8MHx8fDA%3D",
                  //             fit: BoxFit.cover,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     Center(
                  //       child: Container(
                  //         height: 120.h,
                  //         width: 133.w,
                  //         decoration: BoxDecoration(
                  //             shape: BoxShape.circle, color: ColorConstants.whiteColor.withOpacity(0.6)),
                  //         child: Center(
                  //             child: Text(
                  //           "Edit",
                  //           style: AppTextStyle.poppinsBoldStyle.copyWith(color: ColorConstants.whiteColor),
                  //         )),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 80.sp,
                  ),
                  CustomOutlineTextFormField(
                    hintText: "First name",
                    filled: true,
                    controller: authProvider.firstNameController,
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
                      hintText: "Last name",
                      filled: true,
                      controller: authProvider.lastNameController,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset(
                          AssetsImages.userIcon,
                        ),
                      ),
                      filledColor: ColorConstants.whiteColor,
                      borderSideColor: ColorConstants.whiteColor,
                    ),
                  ),
                  CustomOutlineTextFormField(
                    hintText: "Email",
                    filled: true,
                    controller: authProvider.emailController,
                    readOnly: true,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SvgPicture.asset(
                        AssetsImages.emailIcon,
                      ),
                    ),
                    filledColor: ColorConstants.whiteColor,
                    borderSideColor: ColorConstants.whiteColor,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: CustomAppButton(
                      title: "Save",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      onPress: () {
                        loadingProvider.setLoading(true);
                        loadingProvider.callUnFocus(context);

                        UpdateProfileService().callUpdateProfileService(context).then((response) {
                          loadingProvider.setLoading(false);
                          if (response!.responseData != null &&
                              response.responseData?.success == true &&
                              (response.responseData!.status == 201 ||
                                  response.responseData!.status == 200)) {
                            ShowToast().showFlushBar(context, message: "Update Profile successfully");
                            authProvider.reset();
                            Future.delayed(Duration(seconds: 2), () {
                              Navigator.of(context).pop();
                            });
                          } else {
                            ShowToast().showFlushBar(context, message: "Profile not update successfully");
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
