import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Constants/ColorConstants/ColorConstants.dart';

class ToastMessage{
  showToast(BuildContext context,String? msg,Color color){
    return Fluttertoast.showToast(
        msg: msg!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor:color,
        textColor: ColorConstants.whiteColor,
        fontSize: 16.0
    );
  }
}