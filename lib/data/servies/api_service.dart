import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprotbuzz/core/helper/shared_preference_helper.dart';
import 'package:sprotbuzz/core/routes/routes.dart';
import 'package:sprotbuzz/core/utilis/my_strings.dart';
import 'package:sprotbuzz/view/component/Snackbar/custom_Snackbar.dart';

class ApiClient extends GetxService {
  SharedPreferences sharedPreferences;

  ApiClient({required this.sharedPreferences});

  Future<ResponseModel?> request(
    String uri,
    String method,
    Map<String, dynamic>? params, {
    bool passHeader = false,
    bool isOnlyAcceptType = false,
  }) async {
    Uri url = Uri.parse(uri);
    http.Response response;

    try {
      if (passHeader) {
        // initToken();
        Map<String, String> headers = {
          "Accept": "application/json",
          if (!isOnlyAcceptType) "Authorization": "tokenType token",
        };
        response = await http.post(url, body: params, headers: headers);
      } else {
        response = await http.post(url, body: params);
      }

      // Handle response status
      if (response.statusCode == 200) {
        handleSuccessResponse(response);
      } else if (response.statusCode == 401) {
        handleUnauthorizedResponse();
      } else if (response.statusCode == 500) {
        handleServerErrorResponse();
      } else {
        handleDefaultResponse();
      }
    } on SocketException {
      return ResponseModel(false, MyStrings.noInternet.tr, 503, '');
    } on FormatException {
      return ResponseModel(false, MyStrings.badResponseMsg.tr, 400, '');
    } catch (e) {
      return ResponseModel(false, MyStrings.somethingWentWrong.tr, 499, '');
    }
    return null;
  }

  // This is Get request
  Future<ResponseModel?> requestGet(
    String uri,
    String method, {
    bool passHeader = false,
    bool isOnlyAcceptType = false,
  }) async {
    Uri url = Uri.parse(uri);
    http.Response response;

    try {
      if (passHeader) {
        // initToken();
        Map<String, String> headers = {
          "Accept": "application/json",
          if (!isOnlyAcceptType) "Authorization": "tokenType token",
        };
        response = await http.get(url, headers: headers);
      } else {
        response = await http.get(url);
      }

      // Handle response status
      if (response.statusCode == 200) {
        return handleSuccessResponse(response);
      } else if (response.statusCode == 401) {
        return handleUnauthorizedResponse();
      } else if (response.statusCode == 500) {
        return handleServerErrorResponse();
      } else {
        return handleDefaultResponse();
      }
    } on SocketException {
      return ResponseModel(false, MyStrings.noInternet.tr, 503, '');
    } on FormatException {
      return ResponseModel(false, MyStrings.badResponseMsg.tr, 400, '');
    } catch (e) {
      return ResponseModel(false, MyStrings.somethingWentWrong.tr, 499, '');
    }
  }

  Future<ResponseModel?> requestForm(
    String uri,
    String method,
    String matchId, {
    bool passHeader = false,
  }) async {
    Uri url = Uri.parse(uri);

    final request = http.MultipartRequest(method, url);
    request.fields['match_id'] = matchId;

    if (passHeader) {
      Map<String, String> headers = {
        "Accept": "application/json",
      };
    }

    final StreamedResponse response;

    try {
      response = await request.send();

      // Handle response status
      if (response.statusCode == 200) {
        return handleSuccessResponseForm(response);
      } else if (response.statusCode == 401) {
        return handleUnauthorizedResponse();
      } else if (response.statusCode == 500) {
        return handleServerErrorResponse();
      } else {
        return handleDefaultResponse();
      }
    } on SocketException {
      return ResponseModel(false, MyStrings.noInternet.tr, 503, '');
    } on FormatException {
      return ResponseModel(false, MyStrings.badResponseMsg.tr, 400, '');
    } catch (e) {
      return ResponseModel(false, MyStrings.somethingWentWrong.tr, 499, '');
    }
  }

  Future<ResponseModel> handleSuccessResponseForm(
      StreamedResponse response) async {
    var model = await response.stream.bytesToString();

    if (model != "") {
      return ResponseModel(true, "Success", 200, model.toString());
    } else {
      CustomSnackBar.showCustomSnackBar(
        errorList: [model.toString()],
        msg: ["Json decoding error"],
        isError: true,
      );
      return ResponseModel(true, MyStrings.serverError.tr, 404,
          model.toString());
    }
  }

  ResponseModel handleSuccessResponse(http.Response response) {
    var model = response.body;

    if (response.body != "") {
      return ResponseModel(true, "Success", 200, model);
    } else {
      CustomSnackBar.showCustomSnackBar(
        errorList: [model],
        msg: ["Json decoding error"],
        isError: true,
      );
      return ResponseModel(true, MyStrings.serverError.tr, 404, response.body);
    }
  }

  ResponseModel handleUnauthorizedResponse() {
    sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
    CustomSnackBar.showCustomSnackBar(
        errorList: ["This Is Wrong Unauthorized response "],
        msg: [],
        isError: true);
    return ResponseModel(false, MyStrings.unAuthorized.tr, 401, '');
  }

  ResponseModel handleServerErrorResponse() {
    return ResponseModel(false, MyStrings.serverError.tr, 500, '');
  }

  ResponseModel handleDefaultResponse() {
    return ResponseModel(false, MyStrings.somethingWentWrong.tr, 499, '');
  }

  void handleUnauthenticated() {
    sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
    sharedPreferences.remove(SharedPreferenceHelper.token);
    // Get.offAllNamed(RouteHelper.loginScreen);
  }
}

class ResponseModel {
  final bool _isSuccess;
  final int _statusCode;
  final String _message;
  final String _responseJson;
  ResponseModel(
      this._isSuccess, this._message, this._statusCode, this._responseJson);

  String get message => _message;
  String get responseJson => _responseJson;
  int get statusCode => _statusCode;
  bool get isSuccess => _isSuccess;

  get imageUrl => null;
}
