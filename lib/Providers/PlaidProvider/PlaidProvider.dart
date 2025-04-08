import 'package:flutter/material.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Components/ShowToast/ShowToast.dart';
import 'package:supportive_app/Models/PlaidModel/PlaidAccessTokenResponseModel.dart';
import 'package:supportive_app/Models/PlaidModel/PlaidLinkResponseModel.dart';
import 'package:supportive_app/Providers/LoadingProvider/LoadingProvider.dart';
import 'package:supportive_app/Services/PlaidService/GetPlaidAccessTokenService.dart';
import 'package:supportive_app/Services/SharePreferencesService/SharePreferenceService.dart';
import 'package:supportive_app/Utils/Constant/KeysConstant.dart';
import 'package:supportive_app/Utils/Constant/RouteConstant.dart';

class PlaidProvider extends ChangeNotifier {
  PlaidLinkResponseModel? plaidLinkResponse;
  PlaidAccessTokenResponseModel? plaidAccessTokenResponse;

  setPlaidLinkResponse(PlaidLinkResponseModel response) {
    plaidLinkResponse = response;
    notifyListeners();
  }

  setPlaidTokenResponse(PlaidAccessTokenResponseModel response) {
    plaidAccessTokenResponse = response;
    notifyListeners();
  }

  callPlaidPayment(BuildContext context) async {
    var loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
    LinkTokenConfiguration configuration = LinkTokenConfiguration(token: plaidLinkResponse!.data!.linkToken!);
    
    try {
      // Create and open the Plaid link
      PlaidLink.create(configuration: configuration);
      PlaidLink.open();
      
      // Listen for success
      PlaidLink.onSuccess.listen((data) {
        debugPrint("Plaid Link Data: ${data.toJson()}");
        debugPrint("Plaid AccessToken: ${data.publicToken}");
        loadingProvider.setLoading(true);
        if (data.publicToken.isNotEmpty && data.metadata.institution != null) {
          GetPlaidAccessTokenService()
              .callGetPlaidAccessTokenService(context,
                  publicToken: data.publicToken, institution: data.metadata.institution)
              .then((response) {
            loadingProvider.setLoading(false);
            if (response!.responseData != null &&
                response.responseData?.success == true &&
                (response.responseData!.status == 201 || response.responseData!.status == 200)) {
              ShowToast().showFlushBar(context, message: "Plaid Login Successfully");
              SharedPreferencesService().setString(KeysConstant.plaidAccessToken, "Plaid Login Successfully");

              Future.delayed(Duration(seconds: 2), () {
                Navigator.of(context).pushNamedAndRemoveUntil(RouteConstant.allChatListPage, (route) => false);
              });
            } else {
              ShowToast()
                  .showFlushBar(context, message: "${response.responseData?.data!.message}", error: true);
            }
          });
        }
      });

      // Listen for errors
      PlaidLink.onExit.listen((data) {
        debugPrint("Plaid Link Exit: ${data.toJson()}");
        if (data.error != null) {
          ShowToast().showFlushBar(context, message: "Plaid Link Error: ${data.error!.message}", error: true);
        }
      });
    } catch (e) {
      debugPrint("Error launching Plaid link: $e");
      ShowToast().showFlushBar(context, message: "Failed to open Plaid link", error: true);
    }
  }
}
