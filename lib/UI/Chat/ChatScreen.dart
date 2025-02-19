import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Components/AppLoader/ShowLoaderLayer.dart';
import 'package:supportive_app/Providers/ChatProvider/ChatProvider.dart';
import 'package:supportive_app/Providers/LoadingProvider/LoadingProvider.dart';
import 'package:supportive_app/Utils/Constant/AssetImages.dart';
import 'package:supportive_app/Utils/Constant/ColorConstants.dart';
import 'package:supportive_app/Utils/HelperFunction.dart';
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
    return Consumer2<LoadingProvider, ChatProvider>(builder: (context, loadingProvider, chatProvider, _) {
      var chatResponse = chatProvider.getChatByIdResponse;
      var chatData = chatResponse != null ? chatResponse.data : null;
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
                            "Last Updated: ${extractTime(chatData!.updatedAt!)}",
                            style: AppTextStyle.poppinsLightStyle
                                .copyWith(color: ColorConstants.textGreyColor, fontSize: 12.sp),
                          ),
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: chatData.messages!.length,
                              itemBuilder: (context, index) {
                                var message = chatData.messages![index];
                                return Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(12.sp),
                                  margin: EdgeInsets.symmetric(vertical: 10.h) +
                                      EdgeInsets.only(
                                          left: message.senderId != null ? 50.sp : 0,
                                          right: message.senderId == null ? 50.sp : 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.sp),
                                    color: message.senderId != null
                                        ? ColorConstants.appPrimaryColor
                                        : ColorConstants.whiteColor,
                                  ),
                                  child: Text(
                                    textAlign: TextAlign.justify,
                                    message.message ?? "",
                                    style: AppTextStyle.poppinsLightStyle.copyWith(
                                        fontSize: 12.sp,
                                        color: message.senderId != null
                                            ? ColorConstants.whiteColor
                                            : ColorConstants.blackColor),
                                  ),
                                );
                                // index == 0
                                //     ? Row(
                                //         children: [
                                //           Expanded(
                                //               child: DottedLine(
                                //             direction: Axis.horizontal,
                                //             dashColor: ColorConstants.textGreyColor,
                                //           )),
                                //           Padding(
                                //             padding: EdgeInsets.symmetric(horizontal: 20.w),
                                //             child: Text(
                                //               "10:30 am - 12/02/26",
                                //               style: AppTextStyle.poppinsLightStyle.copyWith(
                                //                   color: ColorConstants.textGreyColor, fontSize: 12.sp),
                                //             ),
                                //           ),
                                //           Expanded(
                                //               child: DottedLine(
                                //                   direction: Axis.horizontal,
                                //                   dashColor: ColorConstants.textGreyColor)),
                                //         ],
                                //       )
                                //     : SizedBox(),
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
                        onTap: () {},
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
