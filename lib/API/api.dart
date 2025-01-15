import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:convert';
import '../Constants/KeysConstants.dart';
import '../SharedPrefrences/SharedPrefrences.dart';
import '../globals.dart' as globals;
import 'app_exceptions.dart';
class Api {
  static Future<dynamic> getRequestData(String url, BuildContext context,{bool sendToken = false}) async {
    final dio = Dio();
    String apiUrl = globals.baseUrl!+url;
    print("URL: " + apiUrl);
    var responseJson;
    try {
      String? token =
      await SharedPreferencesService().getString(KeysConstants.accessToken);

      final response = await dio.get(
        apiUrl,
        options: Options(
          headers: {
            'Accept':'application/json',
            'Content-type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        )
      );
      print("Response: ${response.statusCode} ${response.data}");
      // Handle other successful responses
      responseJson = _returnListResponse(response);
      print("Response JSON: $responseJson");
      return responseJson;
    } on SocketException {
      print('Socket Exception');
      throw FetchDataException("No Internet Available");
    }
  }

  static Future<dynamic> postRequestData(String url, dynamic body, BuildContext context,
      {bool sendToken = false,}) async {
    final dio = Dio();
    String apiUrl = globals.baseUrl!+url;
    debugPrint("URL: " + apiUrl);

    var responseJson;
    try {
      String? token =
      await SharedPreferencesService().getString(KeysConstants.accessToken);
      debugPrint(token);
      var response = await dio.post(
        apiUrl,
        data:  jsonEncode(body),
          options: Options(
            followRedirects: false,
            // will not throw errors
            validateStatus: (status) => true,
            headers: sendToken
                ? {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            }
                : {
              'Content-Type': 'application/json',
              'Accept':'application/json'

            },
          ));
      print("Response: ${response.statusCode} ${response.data}");
      // Handle other successful responses
        responseJson = _returnListResponse(response);
        print("Response JSON: $responseJson");
        return responseJson;
    } on SocketException {
      throw FetchDataException("No Internet Available");
    }
    //   print("ye response ha:::::::::"+ response.toString());
    //   responseJson = _returnListResponse(response);
    //   print("ye response ha:::::::::"+ responseJson.toString());
    //
    //   return responseJson;
    // }
    // catch(e) {
    //   print(e.toString());
    // }on SocketException {
    //   throw FetchDataException("No Internet Available");
    // }
  }

//  static Future<dynamic> deleteRequest(String url, dynamic body, BuildContext context,
//       {bool sendToken = false}) async {
//     String apiUrl = apiBaseUrl+url;
//     print("URL: " + apiUrl);
//     var responseJson;
//     try {
//       String? token =
//           await SharedPreferencesService().getString(KeysConstants.accessToken);
//       var response = await http.delete(
//         Uri.parse(apiUrl),
//         body: jsonEncode(body),
//         headers: sendToken
//             ? {
//                 'Content-type': 'application/json',
//                 'Authorization': 'Bearer $token',
//               }
//             : {
//                 'Content-type': 'application/json',
//               },
//       );
//       print("ye response ha:::::::::"+ response.body);
//       responseJson = _returnListResponse(response);
//       // print("ye response ha:::::::::"+ responseJson.toString());

//       return responseJson;
//     } on SocketException {
//       throw FetchDataException("No Internet Available");
//     }
//   }


//   static Future<dynamic> putRequestData(String url, dynamic body, BuildContext context,
//       {bool sendToken = false}) async {
//     String apiUrl = apiBaseUrl+url;
//     print("URL: " + apiUrl);
//     var responseJson;
//     try {
//       String? token =
//           await SharedPreferencesService().getString(KeysConstants.accessToken);
//       var response = await http.put(
//         Uri.parse(apiUrl),
//         body: jsonEncode(body),
//         headers: sendToken
//             ? {
//                 'Content-type': 'application/json',
//                 'Authorization': 'Bearer $token',
//               }
//             : {
//                 'Content-type': 'application/json',
//               },
//       );
//       print("ye response ha:::::::::"+ response.body);
//       responseJson = _returnListResponse(response);
//       // print("ye response ha:::::::::"+ responseJson.toString());

//       return responseJson;
//     } on SocketException {
//       throw FetchDataException("No Internet Available");
//     }
//   }


}

dynamic _returnListResponse(Response response) {
  print(response.statusCode);
  switch (response.statusCode) {
    case 200:
      var responseJson = json.encode(response.data);
      return responseJson;
    case 201:
      var responseJson = json.encode(response.data);
      return responseJson;
    case 400:
      throw BadRequestException(response.data);
    case 401:
      throw UnauthorisedException(response.data);
    case 404:
      throw RequestNotFoundException(response.data);
    case 403:
      throw UnautorizationException(response.data);
    case 422:
      throw UnautorizationException(response.data);
    case 500:
      throw InternalServerException(response.data);
    case 503:
      throw ServerNotFoundException(response.data);
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
