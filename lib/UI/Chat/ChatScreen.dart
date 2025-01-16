import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Components/AppLoader/ShowLoaderLayer.dart';
import 'package:supportive_app/Components/ShowToast/ShowToast.dart';
import 'package:supportive_app/Providers/LoadingProvider/LoadingProvider.dart';
import 'package:supportive_app/Providers/PlaidProvider/PlaidProvider.dart';
import 'package:supportive_app/Services/PlaidService/CreatePlaidLinkToken.dart';
import 'package:supportive_app/Utils/Constant/AssetImages.dart';
import 'package:supportive_app/Utils/Constant/ColorConstants.dart';
import 'package:supportive_app/components/CustomBackground/CustomBackground.dart';
import 'package:supportive_app/components/CustomOutlineTextField/CustomOutlineTextField.dart';
import 'package:supportive_app/components/TextStyle/TextStyle.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<LoadingProvider, PlaidProvider>(builder: (context, loadingProvider, plaidProvider, _) {
      return Scaffold(
        body: ShowLoaderLayer(
          startLoading: loadingProvider.isLoading,
          child: CustomBackground(
            widget: Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(top: 50.sp, left: 12.sp, right: 12.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: 25.sp,
                            color: ColorConstants.blackColor,
                          )),
                      Center(
                        child: Text(
                          "Hello, Ask Me\n  Anything...",
                          style: AppTextStyle.poppinsBoldStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Center(
                          child: Text(
                            "Last Updated: 12.02.26",
                            style: AppTextStyle.poppinsLightStyle
                                .copyWith(color: ColorConstants.textGreyColor, fontSize: 12.sp),
                          ),
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(12.sp),
                                      margin: EdgeInsets.symmetric(vertical: 10.h),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12.sp),
                                        color: ColorConstants.whiteColor,
                                      ),
                                      child: Text(
                                        "There are many variations of passages of many variations"
                                        "There are many variations of passages of..There are many"
                                        "variations of passages of.. There are many variations of"
                                        "passages of..There are many variations of passages of.."
                                        "There are many variations of passages of..",
                                        style: AppTextStyle.poppinsLightStyle.copyWith(fontSize: 12.sp),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        width: 250.w,
                                        padding: EdgeInsets.all(12.sp),
                                        margin: EdgeInsets.symmetric(vertical: 10.h),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12.sp),
                                          color: ColorConstants.appPrimaryColor,
                                        ),
                                        child: Text(
                                          "There are many variations of passages of many variations",
                                          style: AppTextStyle.poppinsLightStyle
                                              .copyWith(fontSize: 12.sp, color: ColorConstants.whiteColor),
                                        ),
                                      ),
                                    ),
                                    index == 0
                                        ? Row(
                                            children: [
                                              Expanded(
                                                  child: DottedLine(
                                                direction: Axis.horizontal,
                                                dashColor: ColorConstants.textGreyColor,
                                              )),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                                child: Text(
                                                  "10:30 am - 12/02/26",
                                                  style: AppTextStyle.poppinsLightStyle.copyWith(
                                                      color: ColorConstants.textGreyColor, fontSize: 12.sp),
                                                ),
                                              ),
                                              Expanded(
                                                  child: DottedLine(
                                                      direction: Axis.horizontal,
                                                      dashColor: ColorConstants.textGreyColor)),
                                            ],
                                          )
                                        : SizedBox(),
                                  ],
                                );
                              })),
                    ],
                  ),
                )),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 16.sp) +
                      EdgeInsets.only(bottom: 10.sp),
                  color: ColorConstants.bottomChatFieldContainerColor,
                  child: Row(
                    spacing: 15.w,
                    children: [
                      Expanded(
                          child: CustomOutlineTextFormField(
                        hintText: "Ask me anything",
                        borderRadius: 20.sp,
                        cursorColor: ColorConstants.blackColor,
                        filled: true,
                        readOnly: true,
                        filledColor: ColorConstants.textFieldFilledColor,
                        borderSideColor: ColorConstants.textFieldFilledColor,
                        onTap: () {
                          loadingProvider.setLoading(true);
                          CreatePlaidLinkTokenService()
                              .callCreatePlaidLinkTokenService(context)
                              .then((response) {
                            loadingProvider.setLoading(false);
                            if (response.responseData != null &&
                                response.responseData?.success == true &&
                                (response.responseData!.status == 201 ||
                                    response.responseData!.status == 200)) {
                              plaidProvider.callPlaidPayment();
                            } else {
                              ShowToast().showFlushBar(context,
                                      message:
                                      "${response.responseData != null
                                          ? response.responseData?.data!
                                          : "Please login again"}",
                                      error: true);
                                }
                              });
                            },
                          )),
                      SvgPicture.asset(AssetsImages.sendChatIcon)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
