import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Components/ShowToast/ShowToast.dart';
import 'package:supportive_app/Models/ChatModel/GetChatModel/GetChatByIdResponseModel.dart';
import 'package:supportive_app/Providers/ChatProvider/ChatProvider.dart';
import 'package:supportive_app/Providers/LoadingProvider/LoadingProvider.dart';
import 'package:supportive_app/Services/ChatService/CreateAndDeleteChatService/CreateChatService.dart';
import 'package:supportive_app/Services/ChatService/GetChatService/GetAllChatService.dart';
import 'package:supportive_app/Services/ChatService/SendChatService/SendChatService.dart';
import 'package:supportive_app/Utils/Constant/AssetImages.dart';
import 'package:supportive_app/Utils/Constant/ColorConstants.dart';
import 'package:supportive_app/components/CustomBackground/CustomBackground.dart';
import 'package:supportive_app/components/CustomOutlineTextField/CustomOutlineTextField.dart';
import 'package:supportive_app/Components/TextStyle/TextStyle.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Timer? timer;
  final ScrollController _scrollController = ScrollController();

  dismissTimer() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(seconds: 10), (value) {
      // GetChatByIdService().callGetChatByIdService(context, chatId: widget.data["chat_id"]);
      GetAllChatService().callGetAllChatService(context, isCallLoading: false);
    });

    /// Scroll to bottom after chat loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void dispose() {
    dismissTimer();
    _scrollController.dispose();

    super.dispose();
  }

  /// Function to scroll to the bottom of the chat
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LoadingProvider, ChatProvider>(builder: (context, loadingProvider, chatProvider, _) {
      var chatResponse = chatProvider.getChatByIdResponse;
      var chatData = chatResponse != null ? chatResponse.data : null;
      return Scaffold(
        body: PopScope(
          canPop: true,
          onPopInvokedWithResult: (value, data) {
            chatProvider.reset();
            dismissTimer();
          },
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
                          "Hello, Ask Me\nAnything...",
                          style: AppTextStyle().poppinsBoldStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(vertical: 5.h),
                      //   child: Center(
                      //     child: Text(
                      //       "Last Updated: ${extractTime(chatData!.updatedAt!)}",
                      //       style: AppTextStyle.poppinsLightStyle
                      //           .copyWith(color: ColorConstants.textGreyColor, fontSize: 12.sp),
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                          child: chatData != null
                              ? ListView.builder(
                                  controller: _scrollController, // ✅ Attach Scroll Controller

                                  itemCount: chatData.messages!.length,
                                  itemBuilder: (context, index) {
                                    var message = chatData.messages![index];
                                    return Align(
                                      alignment: message.senderId != null
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: Container(
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
                                          style: AppTextStyle().poppinsLightStyle().copyWith(
                                              fontSize: 12.sp,
                                              color: message.senderId != null
                                                  ? ColorConstants.whiteColor
                                                  : ColorConstants.blackColor),
                                        ),
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
                                  })
                              : SizedBox()),
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
                        filledColor: ColorConstants.textFieldFilledColor,
                        borderSideColor: ColorConstants.textFieldFilledColor,
                        controller: chatProvider.chatMessageController,
                      )),
                      loadingProvider.isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ))
                          : InkWell(
                              onTap: () {
                                if (chatProvider.chatMessageController.text.isNotEmpty) {
                                  loadingProvider.setLoading(true);
                                  chatProvider.chatMessage = chatProvider.chatMessageController.text;
                                  chatProvider.setAddChatByIdResponse(
                                      ChatMessages(
                                          id: "",
                                          chatId: "",
                                          message: chatProvider.chatMessage,
                                          senderId: ""),
                                      "");
                                  chatProvider.cleanChatBox();
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    _scrollToBottom();
                                  });
                                  if (chatProvider.createNewChat) {
                                    CreateChatService().callCreateChatService(context).then((response) {
                                      if (response!.responseData != null &&
                                          response.responseData?.success == true &&
                                          (response.responseData!.status == 201 ||
                                              response.responseData!.status == 200)) {
                                        chatProvider.setCreateNewChatValue(false);
                                        chatProvider.setChatId(response.responseData!.data!.id);

                                        SendChatService()
                                            .callSendChatService(context, response.responseData!.data!.id)
                                            .then((response) {
                                          loadingProvider.setLoading(false);
                                          if (response!.responseData != null &&
                                              response.responseData?.success == true &&
                                              (response.responseData!.status == 201 ||
                                                  response.responseData!.status == 200)) {
                                            /// ✅ Scroll to Bottom after sending message
                                            WidgetsBinding.instance.addPostFrameCallback((_) {
                                              _scrollToBottom();
                                            });
                                          } else {
                                            loadingProvider.setLoading(false);
                                            WidgetsBinding.instance.addPostFrameCallback((_) {
                                              _scrollToBottom();
                                            });
                                            ShowToast().showFlushBar(context,
                                                message: "Chat can't be send. They are some server issue",
                                                error: true);
                                          }
                                        });
                                      } else {
                                        loadingProvider.setLoading(false);
                                      }
                                    });
                                  } else {
                                    SendChatService()
                                        .callSendChatService(context, chatProvider.chatId)
                                        .then((response) {
                                      loadingProvider.setLoading(false);
                                      if (response!.responseData != null &&
                                          response.responseData?.success == true &&
                                          (response.responseData!.status == 201 ||
                                              response.responseData!.status == 200)) {
                                        /// ✅ Scroll to Bottom after sending message
                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                          _scrollToBottom();
                                        });
                                      } else {
                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                          _scrollToBottom();
                                        });
                                        ShowToast().showFlushBar(context,
                                            message: "Chat can't be send. They are some server issue",
                                            error: true);
                                      }
                                    });
                                  }
                                }
                              },
                              child: SvgPicture.asset(AssetsImages.sendChatIcon))
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
