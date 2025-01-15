import 'package:flutter/material.dart';
import 'package:supportive_app/Utils/Constant/ColorConstants.dart';

class CustomBackground extends StatefulWidget {
   CustomBackground({this.widget,this.padding});
Widget? widget;
   EdgeInsetsGeometry? padding;
  @override
  State<CustomBackground> createState() => _CustomBackgroundState();
}

class _CustomBackgroundState extends State<CustomBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          tileMode: TileMode.clamp,
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors:[
          ColorConstants.appPrimaryColor.withOpacity(0.3),
          ColorConstants.whiteColor
        ]),
      ),
      child: widget.widget,
    );
  }
}
