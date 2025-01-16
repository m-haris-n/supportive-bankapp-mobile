import 'package:flutter/material.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:supportive_app/Models/PlaidModel/PlaidLinkResponseModel.dart';

class PlaidProvider extends ChangeNotifier {
  PlaidLinkResponseModel? plaidLinkResponse;

  setPlaidLinkResponse(PlaidLinkResponseModel response) {
    plaidLinkResponse = response;
    notifyListeners();
  }

  callPlaidPayment() {
    LinkTokenConfiguration configuration = LinkTokenConfiguration(token: plaidLinkResponse!.data!.linkToken!);
    PlaidLink.create(configuration: configuration);
    PlaidLink.open();
    PlaidLink.onSuccess.listen((data) {
      print("Link: $data");
      print("Link: ${data.toJson()}");
      print("Link: ${data.metadata.linkSessionId}");
      print("Link: ${data.metadata.accounts}");
      print("Link: ${data.metadata.institution}");
    });
  }
}
