import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    return Scaffold(

      body: CustomBackground(
        padding: EdgeInsets.only(top:50.sp,left: 12.sp,right: 12.sp),
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back,size: 25.sp,color: ColorConstants.blackColor,)),
            Center(
              child:Text("Hello, Ask Me\n  Anything...",style: AppTextStyle.poppinsBoldStyle,textAlign: TextAlign.center,),
            ),
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 5.h),
            child: Center(
              child: Text("Last Updated: 12.02.26",style: AppTextStyle.poppinsLightStyle.copyWith(color: ColorConstants.textGreyColor,fontSize: 12.sp),),
            ),
          ),
            Expanded(
              child:
              ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context,index){
                return
                    Column(
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
                                "There are many variations of passages of..",style: AppTextStyle.poppinsLightStyle.copyWith(
                              fontSize: 12.sp
                          ),),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width:250.w,
                            padding: EdgeInsets.all(12.sp),
                            margin: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.sp),
                              color: ColorConstants.appPrimaryColor,
                            ),
                            child: Text(
                              "There are many variations of passages of many variations"
                              ,style: AppTextStyle.poppinsLightStyle.copyWith(
                                fontSize: 12.sp,
                                color: ColorConstants.whiteColor
                            ),),
                          ),
                        ),
                       index==0? Row(
                          children: [
                            Expanded(child: DottedLine(direction: Axis.horizontal,dashColor: ColorConstants.textGreyColor,)),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 20.w),
                              child: Text("10:30 am - 12/02/26",style: AppTextStyle.poppinsLightStyle.copyWith(color: ColorConstants.textGreyColor,fontSize: 12.sp),),
                            ),
                            Expanded(child: DottedLine(direction: Axis.horizontal,dashColor: ColorConstants.textGreyColor)),

                          ],
                        ):SizedBox(),
                      ],
                    );
              })),
            Container(
              padding: EdgeInsets.all(12.sp),
              color: ColorConstants.bottomChatFieldContainerColor,
              child: Row(
                spacing: 15.w,
                children: [
                  Expanded(child: CustomOutlineTextFormField(
                    hintText: "Ask me anything",
                    borderRadius: 20.sp,
                    cursorColor: ColorConstants.blackColor,
                    filled: true,
                    filledColor: ColorConstants.textFieldFilledColor,
                    borderSideColor: ColorConstants.textFieldFilledColor,
                  )),

                  SvgPicture.asset(AssetsImages.sendChatIcon)
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
