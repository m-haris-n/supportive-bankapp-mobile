import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Components/ShowToast/ShowToast.dart';
import 'package:supportive_app/Providers/LoadingProvider/LoadingProvider.dart';
import 'package:supportive_app/Services/Api/ApiCallFunctions.dart';
import 'package:supportive_app/Services/Api/ApiCallResponse.dart';
import 'package:supportive_app/Utils/Constant/ApiUrl.dart';

class PlaidRefreshService {
  Future<ApiCallResponse<dynamic>?> callPlaidRefreshService(BuildContext context) async {
    var loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
    loadingProvider.setLoading(true);
    
    try {
      var response = await Api().getRequest(context, ApiUrl.plaidRefresh);
      debugPrint("PlaidRefreshResponse: $response");
      
      loadingProvider.setLoading(false);
      
      if (response != null && response['success'] == true) {
        ShowToast().showFlushBar(context, message: "Data refreshed successfully");
        return ApiCallResponse.completed(response);
      } else {
        ShowToast().showFlushBar(context, 
          message: response != null && response['message'] != null 
            ? response['message'] 
            : "Failed to refresh data", 
          error: true);
        return ApiCallResponse.error("Failed to refresh data");
      }
    } catch (e) {
      loadingProvider.setLoading(false);
      debugPrint("PlaidRefreshError: ${e.toString()}");
      ShowToast().showFlushBar(context, message: "Failed to refresh data: ${e.toString()}", error: true);
      return ApiCallResponse.error(e.toString());
    }
  }
}
