import 'package:flutter/material.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Components/ShowToast/ShowToast.dart';
import 'package:supportive_app/Models/PlaidModel/PlaidAccessTokenResponseModel.dart';
import 'package:supportive_app/Models/PlaidModel/PlaidLinkResponseModel.dart';
import 'package:supportive_app/Providers/LoadingProvider/LoadingProvider.dart';
import 'package:supportive_app/Services/PlaidService/GetPlaidAccessTokenService.dart';

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

  callPlaidPayment(BuildContext context) {
    var loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
    LinkTokenConfiguration configuration = LinkTokenConfiguration(token: plaidLinkResponse!.data!.linkToken!);
    PlaidLink.create(configuration: configuration);
    PlaidLink.open();
    PlaidLink.onSuccess.listen((data) {
      debugPrint("Plaid Link Data: ${data.toJson()}");
      debugPrint("Plaid AccessToken: ${data.publicToken}");
      loadingProvider.setLoading(true);
      if (data.publicToken.isNotEmpty) {
        GetPlaidAccessTokenService()
            .callGetPlaidAccessTokenService(context, publicToken: data.publicToken)
            .then((response) {
          loadingProvider.setLoading(false);
          if (response!.responseData != null &&
              response.responseData?.success == true &&
              (response.responseData!.status == 201 || response.responseData!.status == 200)) {
            ShowToast().showFlushBar(context, message: "Plaid Token Create Successfully");
          } else {
            ShowToast()
                .showFlushBar(context, message: "${response.responseData?.data!.message}", error: true);
          }
        });
      }
    });
  }
}
