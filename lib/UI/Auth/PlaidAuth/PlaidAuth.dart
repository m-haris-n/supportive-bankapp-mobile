import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Components/AppLoader/ShowLoaderLayer.dart';
import 'package:supportive_app/Components/ShowToast/ShowToast.dart';
import 'package:supportive_app/Components/TextStyle/TextStyle.dart';
import 'package:supportive_app/Providers/LoadingProvider/LoadingProvider.dart';
import 'package:supportive_app/Providers/PlaidProvider/PlaidProvider.dart';
import 'package:supportive_app/Services/PlaidService/CreatePlaidLinkToken.dart';
import 'package:supportive_app/Utils/Constant/AssetImages.dart';
import 'package:supportive_app/Utils/Constant/ColorConstants.dart';
import 'package:supportive_app/components/CustomAppButton/CustomAppButton.dart';
import 'package:supportive_app/components/CustomBackground/CustomBackground.dart';

class PlaidAuth extends StatelessWidget {
  const PlaidAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<LoadingProvider, PlaidProvider>(builder: (context, loadingProvider, plaidProvider, _) {
      return Scaffold(
        body: ShowLoaderLayer(
          startLoading: loadingProvider.isLoading,
          child: CustomBackground(
            padding: EdgeInsets.only(top: 50.sp, left: 12.sp, right: 12.sp),
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Hello, Ask Me \nAnything...",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.poppinsBoldStyle.copyWith(fontSize: 18.sp, fontWeight: FontWeight.w400),
                ),
                CustomAppButton(
                  title: "Connect with Plaid",
                  btnColor: ColorConstants.whiteColor,
                  textColor: ColorConstants.blackColor,
                  btnIcon: Image.asset(
                    AssetsImages.plaidImage,
                    height: 30,
                    width: 30,
                  ),
                  onPress: () {
                    loadingProvider.setLoading(true);
                    CreatePlaidLinkTokenService().callCreatePlaidLinkTokenService(context).then((response) {
                      loadingProvider.setLoading(false);
                      if (response.responseData != null &&
                          response.responseData?.success == true &&
                          (response.responseData!.status == 201 || response.responseData!.status == 200)) {
                        plaidProvider.callPlaidPayment(context);
                      } else {
                        ShowToast().showFlushBar(context,
                            message:
                                "${response.responseData != null ? response.responseData?.data! : "Please login again"}",
                            error: true);
                      }
                    });
                  },
                ),
                SizedBox()
              ],
            ),
          ),
        ),
      );
    });
  }
}
