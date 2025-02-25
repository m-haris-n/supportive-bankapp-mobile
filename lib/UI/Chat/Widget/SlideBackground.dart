import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Components/ShowToast/ShowToast.dart';
import 'package:supportive_app/Providers/ChatProvider/ChatProvider.dart';
import 'package:supportive_app/Providers/LoadingProvider/LoadingProvider.dart';
import 'package:supportive_app/Services/ChatService/CreateAndDeleteChatService/DeleteChatService.dart';
import 'package:supportive_app/Services/ChatService/PinChatService/PinChatService.dart';
import 'package:supportive_app/Services/ChatService/PinChatService/UnpinChatService.dart';
import 'package:supportive_app/Utils/Constant/ColorConstants.dart';

Future<bool> confirmDismiss(context, direction, String? chatId,
    {bool unpinChat = false, bool swipePinChat = false}) async {
  if (direction == DismissDirection.endToStart) {
    final bool res = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                "Are you sure you want to delete this chat"),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Provider.of<LoadingProvider>(context, listen: false).setLoading(true);

                  DeleteChatService().callDeleteChatService(context, chatId).then((response) {
                    Provider.of<LoadingProvider>(context, listen: false).setLoading(false);

                    if (response!.responseData != null &&
                        response.responseData?.success == true &&
                        (response.responseData!.status == 201 || response.responseData!.status == 200)) {
                      Provider.of<ChatProvider>(context, listen: false)
                          .deleteChatFromResponse(context, chatId, isPinChat: swipePinChat);
                    } else {
                      ShowToast().showFlushBar(context,
                          message:
                              response.responseData!.data ?? "Chat can't delete. They are some server issue",
                          error: true);
                    }
                  });
                },
              ),
            ],
          );
        });
    return res;
  } else {
    final bool res = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                unpinChat
                    ? "Are you sure you want to unpin this chat"
                    : "Are you sure you want to pin this chat"),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text(
                  unpinChat ? "Unpin" : "Pin",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Provider.of<LoadingProvider>(context, listen: false).setLoading(true);
                  if (unpinChat) {
                    UnpinChatService().callUnpinChatService(context, chatId).then((response) {
                      Provider.of<LoadingProvider>(context, listen: false).setLoading(false);

                      if (response!.responseData != null &&
                          response.responseData?.success == true &&
                          (response.responseData!.status == 201 || response.responseData!.status == 200)) {
                        Provider.of<ChatProvider>(context, listen: false)
                            .pinAndUnPinChat(chatId, isPinChat: swipePinChat);
                        Navigator.of(context).pop(false);
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
                            .pinAndUnPinChat(chatId, isPinChat: swipePinChat);
                        Navigator.of(context).pop(false);
                      } else {
                        ShowToast().showFlushBar(context,
                            message: "Chat can't pin. They are some server issue", error: true);
                      }
                    });
                  }
                },
              ),
            ],
          );
        });
    return res;
  }
}

Widget slideRightBackground({bool unpinChat = false}) {
  return Container(
    color: ColorConstants.greenColor,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Text(
            unpinChat ? "Unpin this chat" : "Pin this chat",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
    ),
  );
}

Widget slideLeftBackground() {
  return Container(
    color: Colors.red,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            "Delete",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      alignment: Alignment.centerRight,
    ),
  );
}
