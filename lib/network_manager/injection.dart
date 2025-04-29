import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hiwash_partner/network_manager/utils/print_value.dart';

import '../route/route_strings.dart';

Dio getDio() {
  Dio dio = Dio();

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options, handler) {
        String apiEndPoint = options.path.split('/').last;
        printValue(tag: 'API URL:', '${options.uri}');
        printValue(tag: 'HEADER:$apiEndPoint-->', options.headers);
       // printValue(tag: 'METHOD:$apiEndPoint-->', options.data);

        try {
          printValue(
            tag: 'REQUEST BODY:$apiEndPoint---onRequest--->',
            jsonEncode(options.data),
          );
        } catch (e) {
          printValue(
            tag: 'REQUEST BODY ERROR:$apiEndPoint---onRequest--->',
            e.toString(),
          );
        }

        return handler.next(options);
      },

      onResponse: (Response response, ResponseInterceptorHandler handler) {
        printValue(
          tag: 'API RESPONSE: ${response.requestOptions.path}',
          response.data,
        );
        return handler.next(response);
      },
      onError: (DioException e, handler) async {
        printValue(
          tag: 'STATUS CODE:${e.response?.statusCode}--onError STATUS CODE--->',
          "${e.response?.statusCode ?? ""}",
        );
        printValue(
          tag: 'ERROR DATA :--onError ERROR DATA--->',
          e.response?.data ?? "",
        );
   if (e.response?.statusCode == 400) {
          Get.snackbar(
            "Error",
            e.response?.data["error"]["message"] ??
                "Something went wrong".toString(),
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }
       else if (e.response?.statusCode == 401) {
          Get.snackbar(
            "Error",
            e.response?.data["error"]["message"] ??
                "Something went wrong".toString(),
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
          Get.offAllNamed(RouteStrings.welcomeScreen);
        } else if (e.response?.statusCode == 404) {
          Get.snackbar(
            "Error 404",
            e.response?.data["error"]["message"] ??
                "Something went wrong".toString(),
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        } else if (e.response?.statusCode == 500) {
          //print("object${e.response?.data.toString()}");
          Get.snackbar(
            "Error",
            e.response?.data["error"]["message"] ??
                "Something went wrong".toString(),
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }

        return handler.next(e);
      },
    ),
  );
  return dio;
}
