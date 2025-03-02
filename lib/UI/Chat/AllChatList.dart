import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Components/AppLoader/ShowLoaderLayer.dart';
import 'package:supportive_app/Components/ShowToast/ShowToast.dart';
import 'package:supportive_app/Components/TextStyle/TextStyle.dart';
import 'package:supportive_app/Models/ChatModel/GetChatModel/GetAllChatResponseModel.dart';
import 'package:supportive_app/Providers/ChatProvider/ChatProvider.dart';
import 'package:supportive_app/Providers/LoadingProvider/LoadingProvider.dart';
import 'package:supportive_app/Services/AuthService/GetUserProfileService.dart';
import 'package:supportive_app/Services/ChatService/GetChatService/GetAllChatService.dart';
import 'package:supportive_app/Services/ChatService/GetChatService/GetChatByIdService.dart';
import 'package:supportive_app/Services/SharePreferencesService/SharePreferenceService.dart';
import 'package:supportive_app/UI/Chat/Widget/ShowPinOrDeleteBottomSheet.dart';
import 'package:supportive_app/Utils/Constant/AppIcons.dart';
import 'package:supportive_app/Utils/Constant/AssetImages.dart';
import 'package:supportive_app/Utils/Constant/ColorConstants.dart';
import 'package:supportive_app/Utils/Constant/KeysConstant.dart';
import 'package:supportive_app/Utils/Constant/RouteConstant.dart';
import 'package:supportive_app/Utils/HelperFunction.dart';
import 'package:supportive_app/components/CustomBackground/CustomBackground.dart';

class AllChatListPage extends StatefulWidget {
  const AllChatListPage({super.key});

  @override
  State<AllChatListPage> createState() => _AllChatListPageState();
}

class _AllChatListPageState extends State<AllChatListPage> {
  bool? isVisible = false;

  Future<void> _pullToRefresh() async {
    GetAllChatService().callGetAllChatService(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GetAllChatService().callGetAllChatService(context);
      GetUserProfileService().callGetUserProfileService(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LoadingProvider, ChatProvider>(builder: (context, loadingProvider, chatProvider, _) {
      var getAllChatResponse = chatProvider.getAllChatResponse;
      List<ChatData>? pinnedChats = getAllChatResponse != null &&
              getAllChatResponse.data != null &&
              getAllChatResponse.data!.pinnedChats != [] &&
              getAllChatResponse.data!.pinnedChats!.isNotEmpty
          ? getAllChatResponse.data!.pinnedChats!.where((element) => element.messages!.isNotEmpty).toList()
          : [];
      List<ChatData>? recentChats = getAllChatResponse != null &&
              getAllChatResponse.data != null &&
              getAllChatResponse.data!.chats != [] &&
              getAllChatResponse.data!.chats!.isNotEmpty
          ? getAllChatResponse.data!.chats!.where((element) => element.messages!.isNotEmpty).toList()
          : [];
      return Scaffold(
        body: RefreshIndicator(
          onRefresh: _pullToRefresh,
          child: ShowLoaderLayer(
            startLoading: loadingProvider.isLoading,
            child: InkWell(
              onTap: () {
                setState(() {
                  isVisible = false;
                });
              },
              child: CustomBackground(
                padding: EdgeInsets.only(top: 50.sp, left: 12.sp, right: 12.sp),
                widget: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Conversation",
                              style: TextStyle(
                                color: ColorConstants.blackColor,
                                fontWeight: FontWeight.w600,
                                fontFamily: poppinsBold,
                                fontSize: 24.sp,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isVisible = true;
                                });
                              },
                              child: Icon(AppIcons.settings),
                            )
                          ],
                        ),
                        Expanded(
                            child: ListView(
                          padding: EdgeInsets.zero,
                          physics: AlwaysScrollableScrollPhysics(), // ✅ Important!
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: InkWell(
                                onTap: () {
                                  chatProvider.reset();
                                  chatProvider.setCreateNewChatValue(true);
                                  chatProvider.setChatId(null);

                                  Navigator.of(context).pushNamed(RouteConstant.chatScreen).then((response) {
                                    if (response == true) {
                                      GetAllChatService().callGetAllChatService(context);
                                    }
                                  });
                                },
                                child: Container(
                                  width: 145.w,
                                  height: 45.h,
                                  margin: EdgeInsets.symmetric(vertical: 15.h),
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.sp),
                                      color: ColorConstants.appPrimaryColor),
                                  child: Row(
                                    spacing: 10.sp,
                                    children: [
                                      Container(
                                          height: 24.w,
                                          width: 24.w,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle, color: ColorConstants.whiteColor),
                                          child: Center(
                                              child: Icon(
                                            Icons.add,
                                            size: 18.sp,
                                            color: ColorConstants.blackColor,
                                          ))),
                                      Text("New Chat",
                                          style: TextStyle(
                                            color: ColorConstants.whiteColor,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: poppinsLight,
                                            fontSize: 14.sp,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            pinnedChats != [] && pinnedChats.isNotEmpty
                                ? Text(
                                    "Pin Chat",
                                    style: AppTextStyle().poppinsLightStyle().copyWith(
                                        color: ColorConstants.blackColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp),
                                  )
                                : SizedBox(),
                            pinnedChats != [] && pinnedChats.isNotEmpty
                                ? _pinChatList(context, pinnedChats, chatProvider)
                                : SizedBox(),
                            recentChats != [] && recentChats.isNotEmpty
                                ? Text(
                                    "Chats",
                                    style: AppTextStyle().poppinsLightStyle().copyWith(
                                        color: ColorConstants.blackColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp),
                                  )
                                : SizedBox(),
                            recentChats != [] && recentChats.isNotEmpty
                                ? _recentChatList(context, recentChats, chatProvider)
                                : SizedBox()
                          ],
                        )),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Text(
                              "Long press on a chat to pin it for quick access.",
                              style: TextStyle(
                                color: ColorConstants.greyColor,
                                fontWeight: FontWeight.w300,
                                fontFamily: poppinsLight,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    !isVisible!
                        ? SizedBox()
                        : Visibility(
                            visible: isVisible!,
                            child: Container(
                              height: 95.h,
                              width: 140.w,
                              margin: EdgeInsets.only(top: 30.h, right: 30.w),
                              padding: EdgeInsets.all(8.sp),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.sp),
                                  color: ColorConstants.whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 2),
                                        color: ColorConstants.textGreyColor,
                                        blurRadius: 6)
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: List.generate(chatProvider.settingPopUp.length, (index) {
                                  return InkWell(
                                    onTap: () {
                                      if (index == 0) {
                                        Navigator.of(context).pushNamed(RouteConstant.editProfilePage);
                                      } else if (index == 1) {
                                        Navigator.of(context).pushNamed(RouteConstant.changePasswordPage);
                                      } else {
                                        SharedPreferencesService().remove(KeysConstant.userId);
                                        SharedPreferencesService().remove(KeysConstant.accessToken);
                                        Navigator.pushNamedAndRemoveUntil(
                                            context, RouteConstant.login, (route) => false);
                                      }
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "${chatProvider.settingPopUp[index]}",
                                          style: AppTextStyle().poppinsLightStyle().copyWith(fontSize: 12.sp),
                                        ),
                                        chatProvider.settingPopUp.length == index + 1
                                            ? SizedBox()
                                            : Divider(),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ),
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

  _pinChatList(BuildContext context, List<ChatData>? pinChat, ChatProvider chatProvider) {
    return Container(
      padding: EdgeInsets.all(8.sp),
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.sp),
        color: ColorConstants.whiteColor,
      ),
      child: ListView.builder(
          itemCount: pinChat!.length,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            ChatData chatData = pinChat[index];
            List<Messages>? chatMessage = chatData.messages;
            return chatMessage != null && chatMessage != [] && chatMessage.isNotEmpty
                ? InkWell(
                    onLongPress: () =>
                        showPinOrDeleteBottomSheet(context, chatMessage.first.chatId!, isPinChat: true),
                    onTap: () {
                      Provider.of<LoadingProvider>(context, listen: false).setLoading(true);

                      GetChatByIdService()
                          .callGetChatByIdService(context, chatId: chatMessage.first.chatId)
                          .then((response) {
                        if (response.responseData != null &&
                            response.responseData?.success == true &&
                            (response.responseData!.status == 201 || response.responseData!.status == 200)) {
                          chatProvider.setCreateNewChatValue(false);
                          chatProvider.setChatId(chatMessage.first.chatId!);

                          Navigator.of(context).pushNamed(RouteConstant.chatScreen).then((response) {
                            if (response == true) {
                              GetAllChatService().callGetAllChatService(context);
                            }
                          });
                        } else {
                          ShowToast().showFlushBar(context,
                              message:
                                  "${response.responseData != null ? response.responseData?.error != null ? response.responseData?.error : "Please login again" : "Please login again"}",
                              error: true);
                        }
                      });
                    },
                    child: Column(
                      children: [
                        Row(
                          spacing: 10.w,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AssetsImages.pinIcon,
                              height: 20.h,
                            ),
                            Expanded(
                              child: Column(
                                spacing: 2.h,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    chatMessage.first.message!,
                                    style: AppTextStyle()
                                        .poppinsLightStyle()
                                        .copyWith(color: ColorConstants.blackColor, fontSize: 12.sp),
                                  ),
                                  Text(chatMessage.first.message!,
                                      style: AppTextStyle().poppinsLightStyle().copyWith(fontSize: 12.sp)),
                                ],
                              ),
                            ),
                            Text(
                              extractTime(chatMessage.first.createdAt!),
                              style: AppTextStyle()
                                  .poppinsLightStyle()
                                  .copyWith(color: ColorConstants.textGreyColor),
                            )
                          ],
                        ),
                        index == pinChat.length - 1
                            ? SizedBox()
                            : Divider(
                                color: ColorConstants.textGreyColor.withOpacity(0.2),
                                thickness: 1.sp,
                              ),
                      ],
                    ),
                  )
                : SizedBox();
          }),
    );
  }

  _recentChatList(BuildContext context, List<ChatData>? recentChat, ChatProvider chatProvider) {
    return Container(
      padding: EdgeInsets.all(8.sp),
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.sp),
        color: ColorConstants.whiteColor,
      ),
      child: ListView.builder(
          itemCount: recentChat!.length,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            ChatData chatData = recentChat[index];
            List<Messages>? chatMessage = chatData.messages;
            return chatMessage != null && chatMessage != [] && chatMessage.isNotEmpty
                ? InkWell(
                    onLongPress: () => showPinOrDeleteBottomSheet(context, chatMessage.first.chatId!),
                    onTap: () {
                      Provider.of<LoadingProvider>(context, listen: false).setLoading(true);

                      GetChatByIdService()
                          .callGetChatByIdService(context, chatId: chatMessage.first.chatId)
                          .then((response) {
                        if (response.responseData != null &&
                            response.responseData?.success == true &&
                            (response.responseData!.status == 201 || response.responseData!.status == 200)) {
                          chatProvider.setCreateNewChatValue(false);
                          chatProvider.setChatId(chatMessage.first.chatId!);

                          Navigator.of(context).pushNamed(RouteConstant.chatScreen).then((response) {
                            if (response == true) {
                              GetAllChatService().callGetAllChatService(context);
                            }
                          });
                        } else {
                          ShowToast().showFlushBar(context,
                              message:
                                  "${response.responseData != null ? response.responseData?.error != null ? response.responseData?.error : "Please login again" : "Please login again"}",
                              error: true);
                        }
                      });
                    },
                    child: Column(
                      children: [
                        Row(
                          spacing: 10.w,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              AssetsImages.celebrationIcon,
                              height: 20.h,
                            ),
                            Expanded(
                              child: Column(
                                spacing: 2.h,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    chatMessage.first.message!,
                                    style: AppTextStyle()
                                        .poppinsLightStyle()
                                        .copyWith(color: ColorConstants.blackColor, fontSize: 12.sp),
                                  ),
                                  Text(chatMessage.first.message!,
                                      style: AppTextStyle().poppinsLightStyle().copyWith(fontSize: 12.sp)),
                                ],
                              ),
                            ),
                            Text(
                              extractTime(chatMessage.first.createdAt!),
                              style: AppTextStyle()
                                  .poppinsLightStyle()
                                  .copyWith(color: ColorConstants.textGreyColor),
                            )
                          ],
                        ),
                        index == recentChat.length - 1
                            ? SizedBox()
                            : Divider(
                                color: ColorConstants.textGreyColor.withOpacity(0.2),
                                thickness: 1.sp,
                              ),
                      ],
                    ),
                  )
                : SizedBox();
          }),
    );
  }
}
