import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supportive_app/Constants/AssetConstants/AssetConstants.dart';
import 'package:supportive_app/Constants/ColorConstants/ColorConstants.dart';
import 'package:supportive_app/components/CustomBackground/CustomBackground.dart';
import 'package:supportive_app/components/TextStyle/TextStyle.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List chatList =[
    {
      "image":AssetConstants.pinIcon,
      "title":"There are many variations of passages...",
      "description":"There are many variations of passages of Lorem"
    },
    {
      "image":AssetConstants.celebrationIcon,
      "title":"There are many variations of passages...",
      "description":"There are many variations of passages of Lorem"
    },
    {
      "image":AssetConstants.celebrationIcon,
      "title":"There are many variations of passages...",
      "description":"There are many variations of passages of Lorem"
    },
    {
      "image":AssetConstants.celebrationIcon,
      "title":"There are many variations of passages...",
      "description":"There are many variations of passages of Lorem"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        padding: EdgeInsets.only(top:50.sp,left: 12.sp,right: 12.sp),
        widget: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Conversation",style: AppTextStyle.poppinsBoldStyle,),
                  Container(
                    height: 44.h,
                    width: 44.w,
                    decoration: BoxDecoration(
                       shape: BoxShape.circle
                    ),
                    child: ClipOval(
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(AssetConstants.profileAvatar),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 145.w,
                    height: 45.h,
                    margin: EdgeInsets.symmetric(vertical: 15.h),
                    padding: EdgeInsets.all(15),
                  
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.sp),
                      color: ColorConstants.appPrimaryColor
                    ),
                    child: Row(
                      spacing: 10.sp,
                      children: [
                        Container(
                            height: 24.h,
                            width: 24.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorConstants.whiteColor
                            ),
                            child: Center(child: Icon(Icons.add,size: 25.sp,color: ColorConstants.blackColor,))),
                        Text("New Chat",style: AppTextStyle.poppinsLightStyle.copyWith(color: ColorConstants.whiteColor),)
                      ],
                    ),
                  ),
                  Icon(Icons.search,size: 35.sp,)
                ],
              ),
              Text("Pin Chat",style: AppTextStyle.poppinsLightStyle.copyWith(color: ColorConstants.blackColor,fontWeight: FontWeight.w500,fontSize: 14.sp),),
              _pinChatList(context),
              Text("Recent",style: AppTextStyle.poppinsLightStyle.copyWith(color: ColorConstants.blackColor,fontWeight: FontWeight.w500,fontSize: 14.sp),),
              _recentChatList(context)
            ],
          ),
        ),
      ),
    );
  }
  _pinChatList(BuildContext context){
    return Container(
      padding: EdgeInsets.all(8.sp),
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.sp),
          color: ColorConstants.whiteColor,
      ),
      child: ListView.builder(
          itemCount: chatList.length,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemBuilder: (context,index){
        return  Column(
          children: [
            Row(
              spacing: 10.w,
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(chatList[index]["image"],height: 20.h,),
                  Column(
                    spacing: 2.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(chatList[index]["title"],style: AppTextStyle.poppinsLightStyle.copyWith(
                        color: ColorConstants.blackColor,
                        fontSize: 12.sp
                      ),),
                      SizedBox(
                        width: 250.w,
                        child: Text(chatList[index]["description"],style: AppTextStyle.poppinsLightStyle.copyWith(
                          fontSize: 12.sp
                        )),
                      ),

                    ],
                  ),
                  Text(
                    "6:12",
                    style: AppTextStyle.poppinsLightStyle.copyWith(
                      color: ColorConstants.textGreyColor
                    ),
                  )
                ],
              ),
           index== chatList.length-1 ? SizedBox() :Divider(
              color: ColorConstants.textGreyColor.withOpacity(0.2),
              thickness: 1.sp,
            ),
          ],
        );
      }),
    );
  }
  _recentChatList(BuildContext context){
    return
      Container(
        padding: EdgeInsets.all(8.sp),
        margin: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.sp),
          color: ColorConstants.whiteColor,
        ),
        child: ListView.builder(
            itemCount: chatList.length,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (context,index){
              return  Column(
                children: [
                  Row(
                    spacing: 10.w,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(chatList[index]["image"],height: 20.h,),
                      Column(
                        spacing: 2.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(chatList[index]["title"],style: AppTextStyle.poppinsLightStyle.copyWith(
                              color: ColorConstants.blackColor,
                              fontSize: 12.sp
                          ),),
                          SizedBox(
                            width: 250.w,
                            child: Text(chatList[index]["description"],style: AppTextStyle.poppinsLightStyle.copyWith(
                                fontSize: 12.sp
                            )),
                          ),

                        ],
                      ),
                      Text(
                        "6:12",
                        style: AppTextStyle.poppinsLightStyle.copyWith(
                            color: ColorConstants.textGreyColor
                        ),
                      )
                    ],
                  ),
                  index== chatList.length-1 ? SizedBox() :Divider(
                    color: ColorConstants.textGreyColor.withOpacity(0.2),
                    thickness: 1.sp,
                  ),
                ],
              );
            }),
      );
  }
}
