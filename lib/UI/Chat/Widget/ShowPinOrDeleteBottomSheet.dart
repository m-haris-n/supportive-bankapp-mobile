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
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title & Message
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Text(
                    "Chat Options",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    isPinChat ? "Choose an option for this chat" : "What would you like to do?",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Divider(height: 1),

            // Pin / Unpin Option
            _buildActionItem(
              title: isPinChat ? "Unpin Chat" : "Pin Chat",
              onTap: () {
                Provider.of<LoadingProvider>(context, listen: false).setLoading(true);
                if (isPinChat) {
                  UnpinChatService().callUnpinChatService(context, chatId).then((response) {
                    Provider.of<LoadingProvider>(context, listen: false).setLoading(false);

                    if (response!.responseData != null &&
                        response.responseData?.success == true &&
                        (response.responseData!.status == 201 || response.responseData!.status == 200)) {
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
                          message:
                              response.responseData!.data ?? "Chat can't unpin. They are some server issue",
                          error: true);
                    }
                  });
                } else {
                  PinChatService().callPinChatService(context, chatId).then((response) {
                    Provider.of<LoadingProvider>(context, listen: false).setLoading(false);

                    if (response!.responseData != null &&
                        response.responseData?.success == true &&
                        (response.responseData!.status == 201 || response.responseData!.status == 200)) {
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
            Divider(height: 1),

            // Delete Chat Option
            _buildActionItem(
              title: "Delete Chat",
              isDestructive: true,
              onTap: () {
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
                        message:
                            response.responseData!.data ?? "Chat can't delete. They are some server issue",
                        error: true);
                  }
                });
              },
            ),
            Divider(height: 1),

            // Cancel Button
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: _buildActionItem(
                title: "Cancel",
                isBold: true,
                onTap: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      );
    },
  );
}

// Custom Action Item Widget
Widget _buildActionItem(
    {required String title, required VoidCallback onTap, bool isDestructive = false, bool isBold = false}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      width: double.infinity,
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: isDestructive ? Colors.red : Colors.blue,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    ),
  );
}
