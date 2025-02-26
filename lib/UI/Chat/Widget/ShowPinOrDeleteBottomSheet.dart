import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Components/CustomAppButton/CustomAppButton.dart';
import 'package:supportive_app/Components/ShowToast/ShowToast.dart';
import 'package:supportive_app/Providers/ChatProvider/ChatProvider.dart';
import 'package:supportive_app/Providers/LoadingProvider/LoadingProvider.dart';
import 'package:supportive_app/Services/ChatService/CreateAndDeleteChatService/DeleteChatService.dart';
import 'package:supportive_app/Services/ChatService/PinChatService/PinChatService.dart';
import 'package:supportive_app/Services/ChatService/PinChatService/UnpinChatService.dart';
import 'package:supportive_app/Utils/Constant/ColorConstants.dart';

void showPinOrDeleteBottomSheet(BuildContext context, String? chatId, {bool isPinChat = false}) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                isPinChat
                    ? "Are you sure you want to unpin or delete this chat"
                    : "Are you sure you want to pin or delete this chat"),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomAppButton(
                    title: isPinChat ? "Unpin" : "Pin",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    onPress: () {
                      Provider.of<LoadingProvider>(context, listen: false).setLoading(true);
                      if (isPinChat) {
                        UnpinChatService().callUnpinChatService(context, chatId).then((response) {
                          Provider.of<LoadingProvider>(context, listen: false).setLoading(false);

                          if (response!.responseData != null &&
                              response.responseData?.success == true &&
                              (response.responseData!.status == 201 ||
                                  response.responseData!.status == 200)) {
                            Provider.of<ChatProvider>(context, listen: false)
                                .pinAndUnPinChat(chatId, isPinChat: isPinChat);
                            ShowToast().showFlushBar(
                              context,
                              message: "Chat unpin successfully",
                            );
                            Future.delayed(Duration(milliseconds: 1500), () {
                              Navigator.of(context)
                                ..pop()
                                ..pop();
                            });
                          } else {
                            ShowToast().showFlushBar(context,
                                message: response.responseData!.data ??
                                    "Chat can't unpin. They are some server issue",
                                error: true);
                          }
                        });
                      } else {
                        PinChatService().callPinChatService(context, chatId).then((response) {
                          Provider.of<LoadingProvider>(context, listen: false).setLoading(false);

                          if (response!.responseData != null &&
                              response.responseData?.success == true &&
                              (response.responseData!.status == 201 ||
                                  response.responseData!.status == 200)) {
                            Provider.of<ChatProvider>(context, listen: false)
                                .pinAndUnPinChat(chatId, isPinChat: isPinChat);
                            ShowToast().showFlushBar(
                              context,
                              message: "Chat pin successfully",
                            );
                            Future.delayed(Duration(milliseconds: 1500), () {
                              Navigator.of(context)
                                ..pop()
                                ..pop();
                            });
                          } else {
                            ShowToast().showFlushBar(context,
                                message: "Chat can't pin. They are some server issue", error: true);
                          }
                        });
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: CustomAppButton(
                    title: "Delete",
                    fontSize: 14.sp,
                    btnColor: ColorConstants.redColor,
                    fontWeight: FontWeight.w500,
                    onPress: () {
                      Provider.of<LoadingProvider>(context, listen: false).setLoading(true);

                      DeleteChatService().callDeleteChatService(context, chatId).then((response) {
                        Provider.of<LoadingProvider>(context, listen: false).setLoading(false);

                        if (response!.responseData != null &&
                            response.responseData?.success == true &&
                            (response.responseData!.status == 201 || response.responseData!.status == 200)) {
                          Provider.of<ChatProvider>(context, listen: false)
                              .deleteChatFromResponse(context, chatId, isPinChat: isPinChat);
                          ShowToast().showFlushBar(
                            context,
                            message: "Chat delete successfully",
                          );
                          Future.delayed(Duration(milliseconds: 1500), () {
                            Navigator.of(context)
                              ..pop()
                              ..pop();
                          });
                        } else {
                          ShowToast().showFlushBar(context,
                              message: response.responseData!.data ??
                                  "Chat can't delete. They are some server issue",
                              error: true);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
