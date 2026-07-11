import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../controller/internet_connectivity_controller.dart';
import '../custom_widgets/custom_toast_snack_bar.dart';
import 'api_constant/api_constants.dart';

class ApiService {
  Dio dio = Dio();

  final ConnectionManagerController _controller = Get.find<ConnectionManagerController>();

  Future<dynamic> getMethod(
      {required String uri, required String baseUrl, required dynamic params, required dynamic header}) async {
    var url = Uri.parse(uri);
    bool isConnected = await _controller.checkConnectivity();
    if (isConnected == true) {
      var res = await dio.get(baseUrl + uri,
          options: Options(headers: header, preserveHeaderCase: true), queryParameters: params);
      debugPrint("Post Body:==>${jsonEncode(params)}", wrapWidth: 250);

      return _returnResponse(response: res, api: url, body: {});
    } else {
      ShortMessage.snackBar(title: "No Internet Connection");
    }
  }

  Future<dynamic> putMethod(
      {required String uri, required String baseUrl, required dynamic body, required dynamic header}) async {
    var url = Uri.parse("${APIConstants.getBaseUrl()}$uri");
    bool isConnected = await _controller.checkConnectivity();
    if (isConnected == true) {
      var res = await dio.put(baseUrl + uri,
          options: Options(headers: header, preserveHeaderCase: true), data: jsonEncode(body));
      return _returnResponse(response: res, api: url, body: {});
    } else {
      ShortMessage.snackBar(title: "No Internet Connection");
    }
  }

  Future<dynamic> postMethod(
      {String uri = "", required String baseUrl, required dynamic body, required dynamic header}) async {
    var url = Uri.parse("$baseUrl$uri");
    debugPrint("Post Body:==>${jsonEncode(body)}", wrapWidth: 250);
    bool isConnected = await _controller.checkConnectivity();
    if (isConnected == true) {
      try {
        var res = await dio.post(baseUrl + uri,
            data: jsonEncode(body), options: Options(headers: header, preserveHeaderCase: true));
        debugPrint("HEADER:==>$header");
        return _returnResponse(response: res, api: url, body: body);
      } on DioException catch (e) {
        if (e.response != null) {
          return _returnResponse(response: e.response, api: url, body: body);
        } else {
          // Something happened in setting up or sending the request that triggered an Error
          // print(e.requestOptions.data);
          if (kDebugMode) {
            print(e.message);
          }
          ShortMessage.toast(title: "Failed to load data");
        }
      }
    } else {
      ShortMessage.snackBar(title: "No Internet Connection");
    }
  }

  _returnResponse({required var response, Uri? api, required var body}) {
    log("api response for $api is :==> $response\n\n$body");
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 400:
        ShortMessage.snackBar(title: "Not Authorized");
        return response.data;
      case 500:
        ShortMessage.snackBar(title: "Internal Server Error 500");
        return response.data;
      default:
        ShortMessage.snackBar(title: "Something went wrong");
        return response.data;
    }
  }
}
