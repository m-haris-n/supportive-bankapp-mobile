import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Utils/Constants/ColorConstants/ColorConstants.dart';

class ToastMessage{
  showToast(BuildContext context,String? msg,Color color){
    return Fluttertoast.showToast(
        msg: msg!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:color ?? ColorConstants.appRedColor,
        textColor: ColorConstants.whiteColor,
        fontSize: 16.0
    );
  }
}