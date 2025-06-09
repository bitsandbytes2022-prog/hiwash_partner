import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/instance_manager.dart';
import 'package:hiwash_partner/featuers/auth/auth_controller/auth_controller.dart';
import 'package:hiwash_partner/language/String_constant.dart';
import 'package:hiwash_partner/network_manager/utils/print_value.dart';
import 'package:hiwash_partner/widgets/components/app_snack_bar.dart';

import '../route/route_strings.dart';

Dio getDio() {
  Dio dio = Dio();

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options, handler) {
        String apiEndPoint = options.path.split('/').last;
        printValue(tag: 'API URL:', '${options.uri}');
        printValue(tag: 'HEADER:$apiEndPoint-->', options.headers);

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
          appSnackBar(
            message:
                e.response?.data["error"]["message"] ??
                StringConstant.kSomethingWentWrong.tr.toString(),
          );
        } else if (e.response?.statusCode == 401) {
          /// Todo need to discussion
          /*   AuthController   authController=Get.find();
     print("Refresh Token api");
     authController.refreshToken();
         Get.offAllNamed(RouteStrings.welcomeScreen);*/
         // Get.offAllNamed(RouteStrings.welcomeScreen);
        } else if (e.response?.statusCode == 404) {
          appSnackBar(
            message:
                e.response?.data["error"]["message"] ??
                StringConstant.kSomethingWentWrong.tr.toString(),
          );
        } else if (e.response?.statusCode == 500) {
          appSnackBar(
            message:
                e.response?.data["error"]["message"] ??
                StringConstant.kSomethingWentWrong.tr.toString(),
          );
        }

        return handler.next(e);
      },
    ),
  );
  return dio;
}
