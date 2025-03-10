import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rest_task_manager/app.dart';
import 'package:rest_task_manager/data/model/network_response.dart';
import 'package:http/http.dart';
import 'package:rest_task_manager/ui/controller/auth_controller.dart';
import 'package:rest_task_manager/ui/screens/auth/sing_in_screen.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      Response response = await get(
        uri,
        headers: {'Authorization': 'Bearer ${AuthController.accessToken}'},
      );
      debugPrint('=======================================================');
      debugPrint(response.body);
      debugPrint('=======================================================');
      final decodeData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodeData,
        );
      } else if (response.statusCode == 401) {
        _redirectToLogInPage();
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (error) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: error.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest(
    String url,
    Map<String, dynamic> body,
  ) async {
    try {
      Uri uri = Uri.parse(url);
      Response response = await post(
        uri,
        body: jsonEncode(body),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ${AuthController.accessToken}',
        },
      );
      debugPrint('=======================================================');
      debugPrint(response.body);
      debugPrint('=======================================================');
      final decodeData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodeData,
        );
      } else if (response.statusCode == 401) {
        _redirectToLogInPage();
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: decodeData['errorMessage'],
        );
      }
    } catch (error) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: error.toString(),
      );
    }
  }

  static Future<void> _redirectToLogInPage() async {
    await AuthController.clearAllData();
    Navigator.pushAndRemoveUntil(
      TaskManagerApp.globalKey.currentContext!,
      MaterialPageRoute(builder: (context) => SingInScreen()),
      (route) => false,
    );
  }
}
