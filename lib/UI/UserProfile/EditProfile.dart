import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supportive_app/Components/CustomAppButton/CustomAppButton.dart';
import 'package:supportive_app/Components/CustomOutlineTextField/CustomOutlineTextField.dart';
import 'package:supportive_app/Components/TextStyle/TextStyle.dart';
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
    return Scaffold(
      body: CustomBackground(
        padding: EdgeInsets.only(top: 50.sp, left: 12.sp, right: 12.sp),
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
                  "Edit Profile",
                  style: AppTextStyle.poppinsBoldStyle,
                ),
              ],
            ),
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                Center(
                  child: Container(
                    height: 120.h,
                    width: 133.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Image.network(
                        "https://images.unsplash.com/photo-1543610892-0b1f7e6d8ac1?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fHByb2ZpbGUlMjBpbWFnZXN8ZW58MHx8MHx8fDA%3D",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 120.h,
                    width: 133.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: ColorConstants.whiteColor.withOpacity(0.6)),
                    child: Center(
                        child: Text(
                      "Edit",
                      style: AppTextStyle.poppinsBoldStyle.copyWith(color: ColorConstants.whiteColor),
                    )),
                  ),
                ),
              ],
            ),
            CustomOutlineTextFormField(
              hintText: "Name",
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
                hintText: "Phone",
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
              hintText: "Email",
              filled: true,
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
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
