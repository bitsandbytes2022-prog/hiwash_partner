import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:hiwash_partner/language/String_constant.dart';

void appSnackBar({
  String? title,
  String? message,
  SnackPosition? position,
  Color? backgroundColor,
  Color? textColor,
  Duration? duration,
}) {
  Get.snackbar(
    title ?? StringConstant.kError.tr,
    message ?? StringConstant.kSomethingWentWrong.tr,
    snackPosition: position ?? SnackPosition.TOP,
    backgroundColor: backgroundColor ?? Colors.red,
    colorText: textColor ?? Colors.white,
    duration: duration ?? const Duration(seconds: 3),
  );
}
