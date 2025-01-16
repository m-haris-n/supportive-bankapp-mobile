import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:supportive_app/Components/ShowToast/ShowToast.dart';
import 'package:supportive_app/Services/SharePreferencesService/SharePreferenceService.dart';
import 'package:supportive_app/Utils/Constant/ApiUrl.dart';
import 'package:supportive_app/Utils/Constant/KeysConstant.dart';
import 'ApiCallExceptions.dart';

class Api {
  Dio _dio = Dio();

  Future<dynamic> getRequest(context, String apiEndPoint, {bool sendToken = true, bool checkAuthToken = false}) async {
    String apiURLAddress = ApiUrl.apiBaseUrl + apiEndPoint;
    debugPrint("URL: $apiURLAddress");
    String? token = await SharedPreferencesService().getString(KeysConstant.accessToken);
    debugPrint("Token: $token");
    var responseJson;
    try {
      var response = await _dio.get(apiURLAddress,
          options: Options(
              headers: sendToken
                  ? {
                      "accept": "application/json",
                      "Authorization": "Bearer $token",
                    }
                  : {
                      "accept": "application/json",
                    }));
      responseJson = _returnListResponse(response);
      return responseJson;
    } on DioException catch (e) {
      if (e.response!.data["message"].runtimeType == String) {
      } else {}
      debugPrint("Get Api Call Error: $e");
      debugPrint("Get Api Call Error: ${e.error}");
      debugPrint("Get Api Call Error Response: ${e.response}");
      ShowToast().showFlushBar(context, message: "${e.response!}", error: true);
    }
  }

  Future<dynamic> postRequest(context, String apiEndPoint, dynamic body,
      {bool sendToken = false, bool uploadDocument = false}) async {
    String apiURLAddress = ApiUrl.apiBaseUrl + apiEndPoint;

    debugPrint("URL: $apiURLAddress");
    String? token = await SharedPreferencesService().getString(KeysConstant.accessToken);
    debugPrint("Token: $token");
    var responseJson;
    try {
      var response = await _dio.post(apiURLAddress,
          options: Options(
              headers: uploadDocument
                  ? {
                      'accept': 'application/json',
                      'Content-Type': 'multipart/form-data',
                      "Authorization": "Bearer $token",
                    }
                  : sendToken
                      ? {
                          "accept": "application/json",
                          "Authorization": "Bearer $token",
                        }
                      : {
                          "accept": "application/json",
                        }),
          data: uploadDocument ? body : jsonEncode(body));
      responseJson = _returnListResponse(response);
      return responseJson;
    } on DioException catch (e) {
      debugPrint("Post Api Call Error: $e");
      debugPrint("Post Api Call Error: ${e.error}");
      print(e.response);
      // debugPrint(e.response!.data);
      // if (e.response!.data["message"].runtimeType == String) {
      // } else {}
      // ShowToast().showFlushBar(context, message: "${e.response!}", error: true);
      responseJson = _returnListResponse(e.response!);
      return responseJson;
    }
  }

  Future<dynamic> patchRequest(context, String apiEndPoint, dynamic body,
      {bool sendToken = false, bool uploadDocument = false}) async {
    String apiURLAddress = ApiUrl.apiBaseUrl + apiEndPoint;

    debugPrint("URL: $apiURLAddress");
    String? token = await SharedPreferencesService().getString(KeysConstant.accessToken);
    debugPrint("Token: $token");
    var responseJson;
    try {
      var response = await _dio.patch(apiURLAddress,
          options: Options(
              headers: uploadDocument
                  ? {
                      'accept': 'application/json',
                      'Content-Type': 'multipart/form-data',
                      "Authorization": "Bearer $token",
                    }
                  : sendToken
                      ? {
                          "accept": "application/json",
                          "Authorization": "Bearer $token",
                        }
                      : {
                          "accept": "application/json",
                        }),
          data: uploadDocument ? body : jsonEncode(body));
      responseJson = _returnListResponse(response);
      return responseJson;
    } on DioException catch (e) {
      if (e.response!.data["message"].runtimeType == String) {
      } else {}
      print(e.message);
      responseJson = _returnListResponse(e.response!);
      debugPrint("Update Api Call Error: $e");
      debugPrint("Update Api Call Error: ${e.error}");
      print(e.response);
      debugPrint(e.response!.data);
      ShowToast().showFlushBar(context, message: "${e.response!}", error: true);
      return null;
    }
  }

  Future<dynamic> deleteRequest(context, String apiEndPoint, {bool sendToken = true, int? index}) async {
    String apiURLAddress = ApiUrl.apiBaseUrl + apiEndPoint;
    debugPrint("URL: " + apiURLAddress);
    String? token = await SharedPreferencesService().getString(KeysConstant.accessToken);
    debugPrint("Token: $token");
    var responseJson;
    try {
      var response = await _dio.delete(apiURLAddress,
          options: Options(
              headers: sendToken
                  ? {
                      "accept": "application/json",
                      "Authorization": "Bearer $token",
                    }
                  : {
                      "accept": "application/json",
                    }));
      responseJson = _returnListResponse(response);
      return responseJson;
    } on DioException catch (e) {
      if (e.response!.data["message"].runtimeType == String) {
      } else {}
      debugPrint("Delete Api Call Error: $e");
      debugPrint("Delete Api Call Error: ${e.error}");
      print(e.response);
      debugPrint(e.response!.data);
      ShowToast().showFlushBar(context, message: "${e.response!}", error: true);
      return null;
    }
  }
}

dynamic _returnListResponse(Response<dynamic> response) {
  debugPrint("StatusCode: ${response.statusCode}");
  switch (response.statusCode) {
    case 200:
      var responseJson = response.data;
      return responseJson;
    case 201:
      var responseJson = response.data;
      return responseJson;
    case 409:
      var responseJson = response.data;
      return responseJson;
    case 404:
      var responseJson = response.data;
      return responseJson;
    case 401:
      var responseJson = response.data;
      return responseJson;
    case 400:
      throw BadRequestException(response.data.toString());
    case 400:
      throw BadRequestException(response.data.toString());
    case 403:
      throw UnAuthorizationException(response.data.toString());

    case 500:
      throw InternalServerException(response.data.toString());
    case 503:
      throw ServerNotFoundException(response.data.toString());
    default:
      throw FetchDataException(
          'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
