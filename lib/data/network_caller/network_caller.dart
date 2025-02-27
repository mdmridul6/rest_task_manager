import 'dart:convert';

import 'package:rest_task_manager/data/model/network_response.dart';
import 'package:http/http.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      Response response = await get(uri);
      final decodeData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodeData,
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
        headers: {'content-type': 'application/json'},
      );
      final decodeData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodeData,
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
}
