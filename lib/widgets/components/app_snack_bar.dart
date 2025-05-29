import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

void appSnackBar({
  String? title,
  String? message,
  SnackPosition? position,
  Color? backgroundColor,
  Color? textColor,
  Duration? duration,
}) {
  Get.snackbar(
    title ?? 'Error',
    message ?? 'Something went wrong',
    snackPosition: position ?? SnackPosition.TOP,
    backgroundColor: backgroundColor ?? Colors.red,
    colorText: textColor ?? Colors.white,
    duration: duration ?? const Duration(seconds: 3),
  );
}
