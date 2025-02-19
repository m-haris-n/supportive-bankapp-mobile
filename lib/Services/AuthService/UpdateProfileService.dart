import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Models/AuthModel/ProfileModel/UpdateProfileRequestModel.dart';
import 'package:supportive_app/Models/AuthModel/ProfileModel/UpdateProfileResponseModel.dart';
import 'package:supportive_app/Providers/AuthProvider/AuthProvider.dart';
import 'package:supportive_app/Services/Api/ApiCallFunctions.dart';
import 'package:supportive_app/Services/Api/ApiCallResponse.dart';
import 'package:supportive_app/Services/SharePreferencesService/SharePreferenceService.dart';
import 'package:supportive_app/Utils/Constant/ApiUrl.dart';
import 'package:supportive_app/Utils/Constant/KeysConstant.dart';

class UpdateProfileService {
  Future<ApiCallResponse<UpdateProfileResponseModel>?> callUpdateProfileService(BuildContext context) async {
    var userId = await SharedPreferencesService().getString(KeysConstant.userId);

    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    UpdateProfileRequestModel requestModel = UpdateProfileRequestModel(id: userId);
    try {
      var response = await Api().patchRequest(context, ApiUrl.updateProfile, requestModel.toJson());
      debugPrint("UpdateProfileResponse:$response");
      UpdateProfileResponseModel responseModel = UpdateProfileResponseModel.fromJson(response);
      debugPrint("UpdateProfileResponseModel:${responseModel.toJson()}");
      authProvider.setUpdateProfileResponse(responseModel);
      return ApiCallResponse.completed(responseModel);
    } catch (e) {
      debugPrint("UpdateProfileResponseError:${e.toString()}");
      return ApiCallResponse.error(e.toString());
    }
  }
}
